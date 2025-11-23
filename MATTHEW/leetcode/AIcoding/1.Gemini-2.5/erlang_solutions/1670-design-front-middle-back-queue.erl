-module(Solution).
-export([new/0, pushFront/2, pushMiddle/2, pushBack/2, popFront/1, popMiddle/1, popBack/1]).

-record(solution_state, {queue = []}).

new() ->
    #solution_state{queue = []}.

pushFront(Val, #solution_state{queue = Q}) ->
    #solution_state{queue = [Val | Q]}.

pushMiddle(Val, #solution_state{queue = Q}) ->
    Len = length(Q),
    Idx = Len div 2,
    {Prefix, Suffix} = lists:split(Idx, Q),
    #solution_state{queue = Prefix ++ [Val] ++ Suffix}.

pushBack(Val, #solution_state{queue = Q}) ->
    #solution_state{queue = Q ++ [Val]}.

popFront(#solution_state{queue = Q}) ->
    case Q of
        [] -> {-1, #solution_state{queue = []}};
        [H | T] -> {H, #solution_state{queue = T}}
    end.

popMiddle(#solution_state{queue = Q}) ->
    Len = length(Q),
    case Len of
        0 -> {-1, #solution_state{queue = []}};
        _ ->
            Idx = (Len - 1) div 2,
            {Prefix, [H | Suffix]} = lists:split(Idx, Q),
            {H, #solution_state{queue = Prefix ++ Suffix}}
    end.

popBack(#solution_state{queue = Q}) ->
    case Q of
        [] -> {-1, #solution_state{queue = []}};
        _ ->
            ReversedQ = lists:reverse(Q),
            [H | T] = ReversedQ,
            {H, #solution_state{queue = lists:reverse(T)}}
    end.