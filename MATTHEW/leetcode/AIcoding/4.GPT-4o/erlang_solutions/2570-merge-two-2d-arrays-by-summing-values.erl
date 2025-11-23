-module(solution).
-export([merge_arrays/2]).

merge_arrays(A, B) ->
    lists:foldl(fun({K, V}, Acc) ->
                      case lists:keyfind(K, 1, Acc) of
                          false -> [{K, V} | Acc];
                          {K1, V1} -> [{K, V + V1} | lists:keydelete(K1, 1, Acc)]
                      end
                  end, B, A).