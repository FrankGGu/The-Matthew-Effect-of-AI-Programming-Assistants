-module(find_good_subset).
-export([good_subset/1]).

good_subset(Matrix) ->
  N = length(Matrix),
  M = length(hd(Matrix)),
  good_subset_helper(Matrix, N, M, 0, []).

good_subset_helper(_Matrix, _N, _M, N, Acc) ->
  case Acc of
    [] -> [];
    _ -> Acc
  end;
good_subset_helper(Matrix, N, M, I, Acc) ->
  good_subset_helper(Matrix, N, M, I + 1,
    case Acc of
      [] ->
        good_subset_recursive(Matrix, N, M, [I], [I]);
      _ ->
        Acc
    end).

good_subset_recursive(_Matrix, _N, _M, CurrentSubset, Acc) ->
  case is_good_subset(_Matrix, _N, _M, Acc) of
    true ->
      Acc;
    false ->
      find_next_in_subset(_Matrix, _N, _M, CurrentSubset, Acc)
  end.

find_next_in_subset(Matrix, N, M, CurrentSubset, Acc) ->
  Last = lists:last(CurrentSubset),
  case Last + 1 < N of
    true ->
      good_subset_recursive(Matrix, N, M, lists:sort(CurrentSubset ++ [Last + 1]), lists:sort(CurrentSubset ++ [Last + 1]));
    false ->
      find_next_in_parent_subset(Matrix, N, M, CurrentSubset, Acc)
  end.

find_next_in_parent_subset(Matrix, N, M, [H], _Acc) ->
  [];
find_next_in_parent_subset(Matrix, N, M, CurrentSubset, Acc) ->
  Last = lists:last(CurrentSubset),
  Parent = lists:droplast(CurrentSubset),
  LastParent = lists:last(Parent),
  case LastParent + 1 < length(Matrix) - (length(CurrentSubset) - 1) of
    true ->
      NewSubset = lists:droplast(CurrentSubset) ++ [LastParent + 1],
      PrefixLength = length(NewSubset),
      NewSubsetFull = lists:seq(LastParent + 1, LastParent + 1 + (length(CurrentSubset) - 1)),
      good_subset_recursive(Matrix, N, M, lists:sort(NewSubsetFull), lists:sort(NewSubsetFull));
    false ->
      find_next_in_parent_subset(Matrix, N, M, Parent, Acc)
  end.

is_good_subset(Matrix, _N, M, Subset) ->
  case Subset of
    [] -> false;
    _ ->
      Vectors = [lists:nth(I + 1, Matrix) || I <- Subset],
      Cols = lists:seq(1, M),
      check_cols(Vectors, Cols)
  end.

check_cols(_Vectors, []) ->
  true;
check_cols(Vectors, [H | T]) ->
  case check_col(Vectors, H) of
    true ->
      check_cols(Vectors, T);
    false ->
      false
  end.

check_col(Vectors, Col) ->
  Sum = lists:sum([lists:nth(Col, Vector) || Vector <- Vectors]),
  Sum > 0.