-module(top_k_frequent).
-export([top_k_frequent/2]).

top_k_frequent(Nums, K) ->
    Counts = lists:foldl(fun(N, Acc) ->
                                  case maps:find(N, Acc) of
                                      {ok, C} -> maps:put(N, C + 1, Acc);
                                      error -> maps:put(N, 1, Acc)
                                  end
                              end, #{}, Nums),
    Sorted = lists:sort(fun(_A, _B) ->
                               maps:get(_A, Counts) > maps:get(_B, Counts)
                           end, maps:keys(Counts)),
    lists:sublist(Sorted, 1, K).