-module(solution).
-export([count_subarrays/2]).

count_subarrays(Nums, K) ->
  count_subarrays(Nums, K, 0).

count_subarrays(Nums, K, Acc) ->
  count_subarrays(Nums, K, 0, 0, 0, 0).

count_subarrays(Nums, K, L, R, Count, Max, Acc) ->
  Len = length(Nums),
  if R >= Len ->
    Acc;
  true ->
    case Nums of
      [] ->
        Acc;
      _ ->
        case lists:nth(R+1, Nums) > Max of
          true ->
            count_subarrays_helper(Nums, K, L, R, 1, lists:nth(R+1, Nums), Acc);
          false ->
            count_subarrays_helper(Nums, K, L, R, Count, Max, Acc)
        end
    end.

count_subarrays_helper(Nums, K, L, R, Count, Max, Acc) ->
  Len = length(Nums),
  if R >= Len ->
    Acc;
  true ->
    case lists:nth(R+1, Nums) == Max of
      true ->
        if Count + 1 >= K ->
          count_subarrays_helper(Nums, K, 0, R+1, Count + 1, Max, Acc + (L+1));
        true ->
            count_subarrays_helper(Nums, K, L, R+1, Count + 1, Max, Acc)
        end;
      false ->
        if Count >= K ->
          count_subarrays_helper(Nums, K, 0, R+1, Count, Max, Acc + (L+1));
        true ->
          case lists:nth(R+1, Nums) > Max of
            true ->
              count_subarrays_helper(Nums, K, 0, R+1, 1, lists:nth(R+1, Nums), Acc);
            false ->
              count_subarrays_helper(Nums, K, L, R+1, Count, Max, Acc)
          end
        end
    end.