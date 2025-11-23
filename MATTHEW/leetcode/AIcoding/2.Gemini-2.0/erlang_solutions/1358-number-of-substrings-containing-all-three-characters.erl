-module(number_of_substrings).
-export([number_of_substrings/1]).

number_of_substrings(S) ->
  number_of_substrings(S, 0, 0, 0, 0).

number_of_substrings(S, A, B, C, Count) ->
  Len = length(S),
  number_of_substrings(S, 0, 0, 0, 0, Count, Len).

number_of_substrings(S, L, A, B, C, Count, Len) ->
  if L >= Len then
    Count
  else
    number_of_substrings(S, L, 0, 0, 0, Count, Len, L).

number_of_substrings(S, L, A, B, C, Count, Len, R) ->
  if R >= Len then
    Count
  else
    Char = lists:nth(R + 1, S),
    case Char of
      $a ->
        NewA = A + 1,
        if NewA > 0 and B > 0 and C > 0 then
          number_of_substrings(S, L, NewA, B, C, Count + (Len - R), Len, R + 1)
        else
          number_of_substrings(S, L, NewA, B, C, Count, Len, R + 1)
        end;
      $b ->
        NewB = B + 1,
        if A > 0 and NewB > 0 and C > 0 then
          number_of_substrings(S, L, A, NewB, C, Count + (Len - R), Len, R + 1)
        else
          number_of_substrings(S, L, A, NewB, C, Count, Len, R + 1)
        end;
      $c ->
        NewC = C + 1,
        if A > 0 and B > 0 and NewC > 0 then
          number_of_substrings(S, L, A, B, NewC, Count + (Len - R), Len, R + 1)
        else
          number_of_substrings(S, L, A, B, NewC, Count, Len, R + 1)
        end
    end.