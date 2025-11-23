-module(find_array).
-export([recover_array/1]).

recover_array(Sums) ->
  recover_array_helper(lists:sort(Sums), []).

recover_array_helper([Min | Rest], Acc) ->
  case Rest of
    [] ->
      lists:reverse(Acc);
    _ ->
      Diff = Rest -- [Min],
      case lists:member(Min + lists:nth(1, Diff), Rest) of
        true ->
          recover_array_helper(lists:sort([X - lists:nth(1, Diff) || X <- Diff]), [lists:nth(1, Diff) | Acc]);
        false ->
          recover_array_helper(lists:sort([X || X <- Diff]), [-lists:nth(1, Diff) | Acc])
      end
  end.