-module(minimum_changes).
-export([min_changes/1]).

min_changes(Nums) ->
  N = length(Nums),
  case N of
    0 -> 0;
    _ ->
      lists:foldl(
        fun(Num, Acc) ->
          lists:min([Acc, N - count_elements(Num, Nums)])
        end,
        N,
        lists:usort(Nums)
      )
  end.

count_elements(Element, List) ->
  lists:foldl(
    fun(X, Acc) ->
      case X =:= Element of
        true -> Acc + 1;
        false -> Acc
      end
    end,
    0,
    List
  ).