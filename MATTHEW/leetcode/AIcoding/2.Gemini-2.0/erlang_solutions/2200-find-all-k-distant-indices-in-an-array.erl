-module(k_distant_indices).
-export([find_k_distant_indices/3]).

find_k_distant_indices(Nums, Key, K) ->
  find_k_distant_indices(Nums, Key, K, 0, [], []).

find_k_distant_indices(Nums, Key, K, Index, Acc, Result) ->
  case lists:nth(Index + 1, Nums) of
    Key ->
      find_k_distant_indices(Nums, Key, K, Index + 1, [Index | Acc], Result);
    _ ->
      case Index + 1 =< length(Nums) of
        true ->
          find_k_distant_indices(Nums, Key, K, Index + 1, Acc, Result);
        false ->
          lists:sort(lists:foldl(fun(KeyIndex, Res) ->
                                    lists:foldl(fun(OtherIndex, Acc2) ->
                                                      case abs(KeyIndex - OtherIndex) =< K of
                                                        true ->
                                                          case lists:member(OtherIndex, Acc2) of
                                                            true ->
                                                              Acc2;
                                                            false ->
                                                              [OtherIndex | Acc2]
                                                          end;
                                                        false ->
                                                          Acc2
                                                      end
                                                  end,
                                                  Res, lists:seq(0, length(Nums) - 1))
                                end,
                                [], Acc))
      end
  end.