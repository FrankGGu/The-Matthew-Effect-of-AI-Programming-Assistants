-module(permutations_ii).
-export([permuteUnique/1]).

permuteUnique(Nums) ->
  UniqueNums = lists:sort(Nums),
  permuteUniqueHelper(UniqueNums, []).

permuteUniqueHelper([], Acc) ->
  [lists:reverse(Acc)];
permuteUniqueHelper(Nums, Acc) ->
  permuteUniqueHelperAux(Nums, Acc, []).

permuteUniqueHelperAux([], _, AccList) ->
  AccList;
permuteUniqueHelperAux(Nums, Acc, AccList) ->
  case Nums of
    [H|T] ->
      NewNums = lists:delete(H, Nums),
      case lists:member(lists:reverse([H|Acc]), AccList) of
        true ->
          permuteUniqueHelperAux(NewNums, Acc, AccList);
        false ->
          NewAccList = permuteUniqueHelper(NewNums, [H|Acc]),
          permuteUniqueHelperAux(NewNums, Acc, AccList ++ NewAccList)
      end;
    [] ->
      AccList
  end.