-module(solve).
-export([single_non_duplicate/1]).

single_non_duplicate([]) -> 0;
single_non_duplicate([X]) -> X;
single_non_duplicate([A,B|T]) ->
    if A == B -> single_non_duplicate(T);
       true -> A
    end.