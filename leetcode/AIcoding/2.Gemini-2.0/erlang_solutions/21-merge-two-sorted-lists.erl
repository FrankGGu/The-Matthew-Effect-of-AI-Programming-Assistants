-module(merge_two_lists).
-export([mergeTwoLists/2]).

-spec mergeTwoLists(List1 :: list(), List2 :: list()) -> list().
mergeTwoLists([], L) -> L;
mergeTwoLists(L, []) -> L;
mergeTwoLists([H1|T1], [H2|T2]) ->
  if H1 =< H2 ->
    [H1 | mergeTwoLists(T1, [H2|T2])];
  true ->
    [H2 | mergeTwoLists([H1|T1], T2)]
  end.