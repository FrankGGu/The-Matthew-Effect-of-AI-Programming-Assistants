-module(rank_transform).
-export([array_rank_transform/1]).

array_rank_transform(Arr) ->
  SortedArr = lists:sort(lists:usort(Arr)),
  RankMap = lists:foldl(
    fun(Elem, Acc) ->
      case maps:is_key(Elem, Acc) of
        true -> Acc;
        false -> maps:put(Elem, maps:sz(Acc) + 1, Acc)
      end
    end,
    #{},
    SortedArr
  ),
  [maps:get(Elem, RankMap) || Elem <- Arr].