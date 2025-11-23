-module(solution).
-export([component_value/3]).

dfs(U, P, TargetSum, Graph, Values) ->
    NodeValue = maps:get(U, Values),

    Neighbors = maps:get(U, Graph, []),

    CurrentSubtreeSum = lists:foldl(
        fun(V, AccSum) ->
            case AccSum of
                -1 -> -1;
                _ ->
                    case V == P of
                        true -> AccSum;
                        false ->
                            ChildContribution = dfs(V, U, TargetSum, Graph, Values),
                            case ChildContribution of
                                -1 -> -1;
                                _ -> AccSum + ChildContribution
                            end
                    end
            end
        end,
        NodeValue,
        Neighbors
    ),

    case CurrentSubtreeSum of
        -1 -> -1;
        Sum when Sum > TargetSum -> -1;
        Sum when Sum == TargetSum -> 0;
        Sum -> Sum
    end.

component_value(N, Edges, ValuesList) ->
    Graph = lists:foldl(
        fun([A, B], AccGraph) ->
            AccGraph1 = maps:update_with(A, fun(L) -> [B | L] end, [B], AccGraph),
            maps:update_with(B, fun(L) -> [A | L] end, [A], AccGraph1)
        end,
        maps:new(),
        Edges
    ),

    ValuesMap = lists:foldl(
        fun({Idx, Val}, AccMap) -> maps:put(Idx, Val, AccMap) end,
        maps:new(),
        lists:zip(lists:seq(0, N - 1), ValuesList)
    ),

    TotalSum = lists:sum(ValuesList),

    case TotalSum == 0 of
        true -> N;
        false ->
            Divisors = find_divisors(TotalSum),

            MaxK = lists:foldl(
                fun(S, CurrentMaxK) ->
                    case dfs(0, -1, S, Graph, ValuesMap) of
                        0 ->
                            max(CurrentMaxK, TotalSum div S);
                        S when S == TotalSum ->
                            max(CurrentMaxK, TotalSum div S);
                        _ ->
                            CurrentMaxK
                    end
                end,
                1,
                Divisors
            ),
            MaxK
    end.

find_divisors(N) ->
    SqrtN = trunc(math:sqrt(N)),
    Divs = lists:foldl(
        fun(I, Acc) ->
            case N rem I == 0 of
                true ->
                    Div1 = I,
                    Div2 = N div I,
                    case Div1 == Div2 of
                        true -> [Div1 | Acc];
                        false -> [Div1, Div2 | Acc]
                    end;
                false -> Acc
            end
        end,
        [],
        lists:seq(1, SqrtN)
    ),
    Divs.