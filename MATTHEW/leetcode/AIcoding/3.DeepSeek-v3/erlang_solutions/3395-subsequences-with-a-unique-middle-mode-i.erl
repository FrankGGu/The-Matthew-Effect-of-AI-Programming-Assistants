-module(solution).
-export([count_subsequences/1]).

count_subsequences(Nums) ->
    Counts = lists:foldl(fun(X, Acc) -> 
                            dict:update_counter(X, 1, Acc) 
                         end, dict:new(), Nums),
    Freqs = dict:fold(fun(K, V, Acc) -> 
                        dict:update(V, [K | dict:fetch(V, Acc, [])], Acc) 
                      end, dict:new(), Counts),
    lists:sum([begin
                  case dict:fetch(Freq, Freqs) of
                      [X] -> 
                          Left = dict:fetch(X - 1, Counts, 0),
                          Right = dict:fetch(X + 1, Counts, 0),
                          (1 bsl Left) * (1 bsl Right) - 1;
                      _ -> 0
                  end
               end || Freq <- dict:fetch_keys(Freqs)]).