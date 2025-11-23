-module(maximize_subsequences).
-export([maximum_subsequenceCount/3]).

maximum_subsequenceCount(Text, Pattern) ->
  maximum_subsequenceCount(Text, Pattern, 0, 0, 0).

maximum_subsequenceCount(_Text, [_, _], Count, First, Second) ->
  max(First, Second) + Count.

maximum_subsequenceCount([H|T], [FirstChar, SecondChar], Count, First, Second) ->
  case H of
    FirstChar ->
      maximum_subsequenceCount(T, [FirstChar, SecondChar], Count, First + 1, Second);
    SecondChar ->
      maximum_subsequenceCount(T, [FirstChar, SecondChar], Count + First, First, Second + 1);
    _ ->
      maximum_subsequenceCount(T, [FirstChar, SecondChar], Count, First, Second)
  end.