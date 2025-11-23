-module(three_sum_multiplicity).
-export([three_sum_multiplicity/2]).

three_sum_multiplicity(Arr, Target) ->
    Len = length(Arr),
    Counts = lists:foldl(fun(X, Acc) ->
                                 maps:update_with(X, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Arr),
    Keys = maps:keys(Counts),
    lists:sort(Keys, fun(A, B) -> A < B end),
    Result = lists:foldl(fun(I, Acc) ->
                               lists:foldl(fun(J, Acc2) ->
                                                A = lists:nth(I + 1, Keys),
                                                B = lists:nth(J + 1, Keys),
                                                C = Target - A - B,
                                                if
                                                    C < B ->
                                                        Acc2;
                                                    true ->
                                                        case maps:is_key(C, Counts) of
                                                            true ->
                                                                if
                                                                    A == B, B == C ->
                                                                        N = maps:get(A, Counts),
                                                                        Acc2 + (N * (N - 1) * (N - 2) div 6);
                                                                    A == B, B /= C ->
                                                                        NA = maps:get(A, Counts),
                                                                        NC = maps:get(C, Counts),
                                                                        Acc2 + ((NA * (NA - 1) div 2) * NC);
                                                                    A /= B, B == C ->
                                                                        NA = maps:get(A, Counts),
                                                                        NB = maps:get(B, Counts),
                                                                        Acc2 + (NA * (NB * (NB - 1) div 2));
                                                                    true ->
                                                                        NA = maps:get(A, Counts),
                                                                        NB = maps:get(B, Counts),
                                                                        NC = maps:get(C, Counts),
                                                                        Acc2 + (NA * NB * NC)
                                                                end
                                                            false ->
                                                                Acc2
                                                        end
                                                end
                                        end, Acc, lists:seq(I, length(Keys) - 1))
                         end, 0, lists:seq(1, length(Keys) - 1)),
    Result rem 1000000007.