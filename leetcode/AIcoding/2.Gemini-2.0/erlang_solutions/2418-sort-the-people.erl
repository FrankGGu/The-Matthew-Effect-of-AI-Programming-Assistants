-module(sort_people).
-export([sort_people/2]).

sort_people(Names, Heights) ->
  People = lists:zip(Heights, Names),
  SortedPeople = lists:sort(fun(A, B) -> element(1, A) > element(1, B) end, People),
  [element(2, Person) || Person <- SortedPeople].