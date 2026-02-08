-module(minimum_groups).
-export([min_groups_for_valid_assignment/1]).

min_groups_for_valid_assignment(Groups) ->
  Counts = lists:sort(lists:foldl(fun(X, Acc) ->
                                     case lists:keyfind(X, 1, Acc) of
                                       false ->
                                         [{X, 1} | Acc];
                                       {X, C} ->
                                         lists:keyreplace(X, 1, Acc, {X, C + 1})
                                     end
                                   end, [], Groups)),
  min_groups(Counts).

min_groups(Counts) ->
  min_groups_helper(Counts, hd(tl(Counts, [hd(Counts)]))/1).

min_groups_helper([], _S) ->
  0;
min_groups_helper(Counts, S) ->
  case check_valid(Counts, S) of
    true ->
      sum_groups(Counts, S);
    false ->
      min_groups_helper(Counts, S - 1)
  end.

check_valid([], _S) ->
  true;
check_valid([{_, C} | Rest], S) ->
  if
    C rem (S + 1) == 0 ->
      check_valid(Rest, S);
    C div (S + 1) > 0 andalso C rem (S + 1) =< (C div (S + 1)) * S ->
      check_valid(Rest, S);
    false ->
      case S - 1 of
          0 ->
              false;
          _ ->
              (C rem (S + 1) == 0 or C >= S andalso (C-S) rem (S+1) == 0) andalso check_valid(Rest, S)
      end
  end.

sum_groups([], _S) ->
  0;
sum_groups([{_, C} | Rest], S) ->
  sum_groups(Rest, S) + (C + S) div (S + 1).