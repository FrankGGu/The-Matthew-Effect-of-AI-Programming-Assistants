-module(minimum_pushes_i).
-export([minimum_pushes/1]).

minimum_pushes(Word) ->
  minimum_pushes(Word, 1, 0).

minimum_pushes([], _, Acc) ->
  Acc;
minimum_pushes([_|Rest], Count, Acc) ->
  NewAcc = Acc + Count,
  case length(Rest) of
    Len when Len < 1 ->
      minimum_pushes(Rest, Count, NewAcc);
    Len when Len < 2 ->
      minimum_pushes(lists:sublist(Rest, 1, 1), Count, NewAcc);
    Len when Len < 3 ->
      minimum_pushes(lists:sublist(Rest, 1, 2), Count, NewAcc);
    Len when Len < 4 ->
      minimum_pushes(lists:sublist(Rest, 1, 3), Count, NewAcc);
    Len when Len < 5 ->
      minimum_pushes(lists:sublist(Rest, 1, 4), Count, NewAcc);
    Len when Len < 6 ->
      minimum_pushes(lists:sublist(Rest, 1, 5), Count, NewAcc);
    Len when Len < 7 ->
      minimum_pushes(lists:sublist(Rest, 1, 6), Count, NewAcc);
    Len when Len < 8 ->
      minimum_pushes(lists:sublist(Rest, 1, 7), Count, NewAcc);
    Len when Len < 9 ->
      minimum_pushes(lists:sublist(Rest, 1, 8), Count, NewAcc);
    Len when Len < 10 ->
      minimum_pushes(lists:sublist(Rest, 1, 9), Count, NewAcc);
    Len when Len < 11 ->
      minimum_pushes(lists:sublist(Rest, 1, 10), Count, NewAcc);
    _ ->
      minimum_pushes(lists:sublist(Rest, 1, 11), Count, NewAcc)
  end,

  case length(Rest) of
    Len when Len =< 11 ->
      minimum_pushes([], Count, NewAcc);
    _ ->
      minimum_pushes(lists:sublist(Rest, 12, length(Rest) - 11), Count + 1, NewAcc)
  end.