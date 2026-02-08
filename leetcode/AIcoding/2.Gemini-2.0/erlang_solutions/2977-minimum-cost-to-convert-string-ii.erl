-module(minimum_cost_to_convert_string_ii).
-export([minimum_cost/3]).

minimum_cost(S, Source, Target) ->
    minimum_cost(S, Source, Target, []).

minimum_cost(S, Source, Target, Cache) ->
    N = length(S),
    Costs = lists:seq(0, N),
    minimum_cost_helper(S, Source, Target, Costs, Cache).

minimum_cost_helper(_S, _Source, _Target, Costs, _Cache) ->
    N = length(Costs) -1,
    lists:last(Costs).

minimum_cost_helper(S, Source, Target, Costs, Cache) ->
    N = length(S),
    Len = length(Costs),
    I = Len - 1,

    NewCosts = lists:map(
        fun(Cost, J) ->
            case J of
                0 -> 0;
                _ ->
                    MinCost = Cost + lists:nth(J-1, Costs);
                    lists:foldl(
                        fun(Index, Acc) ->
                            {Start, SourceStr, TargetStr, Cost} = Index,
                            if
                                Start + length(SourceStr) == J,
                                sub_string(S, Start + 1, length(SourceStr)) == SourceStr ->
                                    min(Acc, lists:nth(Start, Costs) + Cost);
                                true ->
                                    Acc
                            end
                        , MinCost, get_indices(Source, Target)
                    )
            end
        end,
        lists:seq(0, I),
        lists:seq(0, I)
    ),
    minimum_cost_helper(S, Source, Target, NewCosts, Cache).

get_indices(Source, Target) ->
    get_indices_helper(Source, Target, 1, []).

get_indices_helper([], [], _, Acc) ->
    lists:reverse(Acc);
get_indices_helper([S | RestS], [T | RestT], Index, Acc) ->
    get_indices_helper(RestS, RestT, Index + 1, Acc ++ get_single_indices(S, T, Index, []));

get_single_indices([], [], _Index, Acc) ->
    lists:reverse(Acc);
get_single_indices([S | RestS], [T | RestT], Index, Acc) ->
    {Start, SourceStr, TargetStr, Cost} = T,
    get_single_indices(RestS, RestT, Index, [{Start, S, TargetStr, Cost} | Acc]).