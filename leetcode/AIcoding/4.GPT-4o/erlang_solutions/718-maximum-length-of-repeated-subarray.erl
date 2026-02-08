-module(solution).
-export([findLength/2]).

findLength(A, B) ->
    N = length(A),
    M = length(B),
    Matrix = lists:duplicate(N + 1, lists:duplicate(M + 1, 0)),
    MaxLen = lists:foldl(fun({I, Row}, Acc) ->
        lists:foldl(fun({J, Val}, Acc) ->
            case lists:nth(J, Row) of
                0 -> Acc;
                _ -> MaxAcc = lists:nth(J - 1, Matrix),
                    NewVal = if lists:nth(I, A) =:= lists:nth(J, B) -> 
                                  MaxAcc + 1;
                              true -> 0
                          end,
                    lists:update_element(J, MaxAcc + 1, Acc)
            end
        end, Acc, lists:zipwith(fun(X, Y) -> {X, Y} end, lists:seq(1, M), Row))
    end, 0, lists:zipwith(fun(X, Y) -> {X, Y} end, lists:seq(1, N), Matrix)),
    MaxLen.