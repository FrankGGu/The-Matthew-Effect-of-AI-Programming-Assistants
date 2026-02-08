-module(solution).
-export([solve/1]).

solve(N) ->
    Digits = integer_to_list(N),
    Len = length(Digits),
    Count = solve_helper(Digits, Len, 0, false, []).

solve_helper([], 0, Acc, _, _) ->
    Acc;
solve_helper([], _, Acc, _, _) ->
    Acc.
solve_helper(Digits, Len, Acc, IsStrictlySmaller, Used) ->
    L = length(Digits),
    case IsStrictlySmaller of
        true ->
            Acc + (lists:seq(1,L) -- [1])
            |> lists:foldl(fun(K, A) -> A + count_distinct(K) end, _);
        false ->
            D = hd(Digits),
            NewDigits = tl(Digits),

            SmallerCount = 
                lists:foldl(fun(I, A) ->
                                case lists:member(I, Used) of
                                    true -> A;
                                    false -> A + solve_helper2(L - 1, Used ++ [I])
                                end
                            end, 0, lists:seq( (case L == Len of true -> 1; false -> 0 end) , D - 1)),

            case lists:member(D, Used) of
                true -> Acc + SmallerCount;
                false -> 
                    solve_helper(NewDigits, Len, Acc + SmallerCount, false, Used ++ [D])
            end
    end.

solve_helper2(0, _) -> 1;
solve_helper2(L, Used) ->
    lists:foldl(fun(I,A) -> 
                    case lists:member(I, Used) of
                        true -> A;
                        false -> A + solve_helper2(L-1, Used ++ [I])
                    end
                end, 0, lists:seq(0,9)).

count_distinct(K) ->
    count_distinct_helper(K, []).

count_distinct_helper(0, _) -> 1;
count_distinct_helper(K, Used) ->
    lists:foldl(fun(I,A) -> 
                    case lists:member(I, Used) of
                        true -> A;
                        false -> A + count_distinct_helper(K-1, Used ++ [I])
                    end
                end, 0, lists:seq( (case K == 1 of true -> 1; false -> 0 end), 9)).