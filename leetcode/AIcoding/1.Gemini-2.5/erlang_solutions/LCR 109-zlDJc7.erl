-module(solution).
-export([openLock/2]).

openLock(Deadends, Target) ->
    DeadendSet = sets:from_list(Deadends),

    case sets:is_element("0000", DeadendSet) of
        true -> -1;
        false ->
            Q = queue:in({"0000", 0}, queue:new()),
            Visited = sets:add("0000", sets:new()),
            bfs(Q, Visited, DeadendSet, Target)
    end.

bfs(Q, Visited, DeadendSet, Target) ->
    case queue:is_empty(Q) of
        true -> -1;
        false ->
            {{CurrentCombination, Turns}, Q1} = queue:out(Q),

            if CurrentCombination == Target ->
                Turns;
            true ->
                NextCombinations = get_next_combinations(CurrentCombination),
                {Q2, Visited2} = lists:foldl(
                    fun(NextCombination, {AccQ, AccVisited}) ->
                        case sets:is_element(NextCombination, DeadendSet) orelse sets:is_element(NextCombination, AccVisited) of
                            true -> {AccQ, AccVisited};
                            false ->
                                {queue:in({NextCombination, Turns + 1}, AccQ), sets:add(NextCombination, AccVisited)}
                        end
                    end,
                    {Q1, Visited},
                    NextCombinations
                ),
                bfs(Q2, Visited2, DeadendSet, Target)
            end
    end.

get_next_combinations(Combination) ->
    lists:flatmap(
        fun(Index) ->
            CurrentChar = lists:nth(Index + 1, Combination),
            Digit = CurrentChar - $0,

            DigitUp = (Digit + 1) rem 10,
            CharUp = DigitUp + $0,
            CombinationUp = lists:replace_nth(Index + 1, CharUp, Combination),

            DigitDown = (Digit - 1 + 10) rem 10,
            CharDown = DigitDown + $0,
            CombinationDown = lists:replace_nth(Index + 1, CharDown, Combination),

            [CombinationUp, CombinationDown]
        end,
        lists:seq(0, 3)
    ).