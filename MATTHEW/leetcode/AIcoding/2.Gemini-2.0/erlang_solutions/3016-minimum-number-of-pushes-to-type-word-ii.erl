-module(minimum_pushes_ii).
-export([minimum_pushes/1]).

minimum_pushes(Words) ->
  minimum_pushes_helper(Words, 0).

minimum_pushes_helper([], Acc) ->
  Acc;
minimum_pushes_helper(Words, Acc) ->
  Chars = string:to_charlist(Words),
  SortedChars = lists:sort(Chars),
  Frequencies = lists:reverse(lists:keysort(2, frequency_counts(SortedChars))),
  Pushes = calculate_pushes(Frequencies),
  Acc + Pushes.

frequency_counts(List) ->
  lists:foldl(fun(X, Acc) ->
                  case lists:keyfind(X, 1, Acc) of
                    false -> [{X, 1} | Acc];
                    {X, Count} -> lists:keyreplace(X, 1, Acc, {X, Count + 1})
                  end
              end, [], List).

calculate_pushes(Frequencies) ->
  calculate_pushes_helper(Frequencies, 1, 0).

calculate_pushes_helper([], _, Acc) ->
  Acc;
calculate_pushes_helper(Frequencies, Press, Acc) ->
  {Take, Remaining} = lists:split(8, Frequencies),
  NewAcc = Acc + lists:sum([Press * F || {_Char, F} <- Take]),
  calculate_pushes_helper(Remaining, Press + 1, NewAcc).