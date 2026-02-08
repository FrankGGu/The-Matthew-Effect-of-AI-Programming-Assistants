-module(solution).
-export([number_of_substrings/1]).

number_of_substrings(S) ->
  number_of_substrings(S, 0).

number_of_substrings([], Acc) ->
  Acc;
number_of_substrings(S, Acc) ->
  number_of_substrings(S, 0, 0, Acc).

number_of_substrings(_, Len, Len, Acc) ->
  Acc;
number_of_substrings(S, Start, Len, Acc) ->
  Sub = lists:sublist(S, Start+1, Len-Start+1),
  case is_dominant(Sub) of
    true ->
      number_of_substrings(S, Start+1, length(S), Acc + 1);
    false ->
      number_of_substrings(S, Start+1, length(S), Acc)
  end.

is_dominant(S) ->
  Ones = count_ones(S, 0),
  Zeros = length(S) - Ones,
  Ones > Zeros.

count_ones([], Acc) ->
  Acc;
count_ones([H|T], Acc) ->
  case H of
    $1 ->
      count_ones(T, Acc + 1);
    _ ->
      count_ones(T, Acc)
  end.