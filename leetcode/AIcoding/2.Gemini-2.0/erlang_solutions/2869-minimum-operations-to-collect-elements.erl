-module(minimum_operations_to_collect_elements).
-export([min_operations/2]).

min_operations(Nums, K) ->
  min_operations(Nums, K, 0, []).

min_operations([], _K, Count, Collected) ->
  case length(Collected) of
    0 -> Count;
    _ -> Count
  end;
min_operations(Nums, K, Count, Collected) ->
  [H|T] = lists:reverse(Nums),
  case H >= K of
    true ->
      min_operations(lists:reverse(T), K, Count + 1, Collected);
    false ->
      case lists:member(H, Collected) of
        true ->
          min_operations(lists:reverse(T), K, Count + 1, Collected);
        false ->
          case length(lists:usort([H|Collected])) >= K of
            true ->
              Count + 1;
            false ->
              min_operations(lists:reverse(T), K, Count + 1, lists:usort([H|Collected]))
          end
      end
  end.