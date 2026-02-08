-module(solution).
-export([count_k_difference/2]).

count_k_difference(Nums, K) ->
    count_pairs(Nums, K, 0).

count_pairs([], _, Count) ->
    Count;
count_pairs([H|T], K, Count) ->
    NewCount = Count + lists:foldl(fun(X, Acc) ->
                                          case abs(H - X) =:= K of
                                              true -> Acc + 1;
                                              false -> Acc
                                          end
                                  end, 0, T),
    count_pairs(T, K, NewCount).