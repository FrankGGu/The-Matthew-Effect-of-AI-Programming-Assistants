-module(open_lock).
-export([open_lock/2]).

open_lock(Deadends, Target) ->
    DeadendsSet = sets:from_list(Deadends),
    if sets:is_element("0000", DeadendsSet) ->
        -1
    else
        Q = queue:new(),
        Q1 = queue:in("0000", Q),
        Visited = sets:add("0000", sets:new()),
        open_lock_helper(DeadendsSet, Target, Q1, Visited, 0)
    end.

open_lock_helper(DeadendsSet, Target, Q, Visited, Steps) ->
    case queue:is_empty(Q) of
        true ->
            -1;
        false ->
            {Value, Q1} = queue:out(Q),
            {ok, CurrLock} = Value,
            if CurrLock == Target ->
                Steps
            else
                Neighbors = get_neighbors(CurrLock),
                FilteredNeighbors = lists:filter(fun(Neighbor) ->
                                                       not sets:is_element(Neighbor, DeadendsSet) and
                                                       not sets:is_element(Neighbor, Visited)
                                                   end, Neighbors),
                NewQ = lists:foldl(fun(Neighbor, AccQ) ->
                                         queue:in(Neighbor, AccQ)
                                     end, Q1, FilteredNeighbors),
                NewVisited = lists:foldl(fun(Neighbor, AccVisited) ->
                                             sets:add(Neighbor, AccVisited)
                                         end, Visited, FilteredNeighbors),
                open_lock_helper(DeadendsSet, Target, NewQ, NewVisited, Steps + 1)
            end
    end.

get_neighbors(Lock) ->
    [get_neighbor(Lock, I, 1) || I <- lists:seq(1, 4)] ++
    [get_neighbor(Lock, I, -1) || I <- lists:seq(1, 4)].

get_neighbor(Lock, Index, Direction) ->
    Digits = string:to_integer(string:substr(Lock, Index, 1)),
    {ok, Digit} = Digits,
    NewDigit = (Digit + Direction + 10) rem 10,
    string:replace(Lock, integer_to_list(Digit), integer_to_list(NewDigit), Index).