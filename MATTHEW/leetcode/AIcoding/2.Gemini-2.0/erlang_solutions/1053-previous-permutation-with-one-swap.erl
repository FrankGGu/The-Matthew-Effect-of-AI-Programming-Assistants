-module(previous_permutation).
-export([prev_perm_opt1/1]).

prev_perm_opt1(A) ->
  N = length(A),
  case find_swap_indices(A, N - 2) of
    {I, J} ->
      swap(A, I, J);
    _ ->
      lists:reverse(A)
  end.

find_swap_indices(A, I) ->
  case I < 0 of
    true ->
      not_found;
    false ->
      case find_j(A, I) of
        not_found ->
          find_swap_indices(A, I - 1);
        J ->
          {I, J}
      end
  end.

find_j(A, I) ->
  find_j_helper(A, I, I + 1).

find_j_helper(A, I, J) ->
  case J >= length(A) of
    true ->
      not_found;
    false ->
      case lists:nth(I + 1, A) > lists:nth(I, A) of
        true ->
          find_j_helper(A, I, J + 1);
        false ->
          case find_max_j(A, I, J) of
            not_found ->
              not_found;
            MaxJ ->
              MaxJ
          end
      end
  end.

find_max_j(A, I, J) ->
  find_max_j_helper(A, I, J, J, lists:nth(J, A)).

find_max_j_helper(A, I, K, MaxJ, MaxVal) ->
  case K >= length(A) of
    true ->
      MaxJ;
    false ->
      Val = lists:nth(K, A),
      case Val < lists:nth(I, A) of
        true ->
          case Val > MaxVal of
            true ->
              find_max_j_helper(A, I, K + 1, K, Val);
            false ->
              find_max_j_helper(A, I, K + 1, MaxJ, MaxVal)
          end;
        false ->
          find_max_j_helper(A, I, K + 1, MaxJ, MaxVal)
      end
  end.

swap(A, I, J) ->
  swap_helper(A, I, J, 0, []).

swap_helper(A, I, J, K, Acc) ->
  case K >= length(A) of
    true ->
      lists:reverse(Acc);
    false ->
      case K of
        I ->
          swap_helper(A, I, J, K + 1, [lists:nth(J + 1, A) | Acc]);
        J ->
          swap_helper(A, I, J, K + 1, [lists:nth(I + 1, A) | Acc]);
        _ ->
          swap_helper(A, I, J, K + 1, [lists:nth(K + 1, A) | Acc])
      end
  end.