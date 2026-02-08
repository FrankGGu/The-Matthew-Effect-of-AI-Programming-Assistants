-module(partition_disjoint).
-export([partition_disjoint/1]).

partition_disjoint(A) ->
  partition_disjoint_helper(A, hd(A), hd(A), 1).

partition_disjoint_helper([H|T], CurrentMax, OverallMax, Index) ->
  case
    H < CurrentMax ->
      partition_disjoint_helper(T, OverallMax, lists:max([OverallMax, H]), Index + 1);
    true ->
      case
        T == [] ->
          Index;
        true ->
          partition_disjoint_helper(T, CurrentMax, lists:max([OverallMax, H]), Index + 1)
      end
  end;
partition_disjoint_helper([], _, _, Index) ->
  Index.