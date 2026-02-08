-module(solution).
-export([open_lock/2]).

open_lock(Deadends, Target) ->
    DeadendsSet = sets:from_list(Deadends),
    InitialCombo = "0000",

    if sets:is_element(InitialCombo, DeadendsSet) ->
        -1;
    true ->
        Queue = queue:in({InitialCombo, 0}, queue:new()),
        Visited = sets:add_element(InitialCombo, sets:new()),
        bfs(Queue, Visited, Target, DeadendsSet)
    end.

bfs(Queue, _Visited, Target, _DeadendsSet) when queue:is_empty(Queue) ->
    -1;
bfs(Queue, Visited, Target, DeadendsSet) ->
    {{value, {CurrentCombo, Steps}}, NewQueue} = queue:out(Queue),

    if CurrentCombo == Target ->
        Steps;
    true ->
        Neighbors = get_neighbors(CurrentCombo),
        {UpdatedQueue, UpdatedVisited} = lists:foldl(
            fun(Neighbor, {AccQueue, AccVisited}) ->
                if not sets:is_element(Neighbor, AccVisited) andalso not sets:is_element(Neighbor, DeadendsSet) ->
                    {queue:in({Neighbor, Steps + 1}, AccQueue), sets:add_element(Neighbor, AccVisited)};
                true ->
                    {AccQueue, AccVisited}
                end
            end,
            {NewQueue, Visited},
            Neighbors
        ),
        bfs(UpdatedQueue, UpdatedVisited, Target, DeadendsSet)
    end.

get_neighbors(Combo) ->
    lists:foldl(
        fun(Index, Acc) ->
            DigitChar = lists:nth(Index + 1, Combo),
            Digit = DigitChar - $0,

            IncDigit = (Digit + 1) rem 10,
            DecDigit = (Digit - 1 + 10) rem 10,

            IncChar = $0 + IncDigit,
            DecChar = $0 + DecDigit,

            IncCombo = lists:replace_nth(Index + 1, IncChar, Combo),
            DecCombo = lists:replace_nth(Index + 1, DecChar, Combo),
            [IncCombo, DecCombo | Acc]
        end,
        [],
        lists:seq(0, 3)
    ).