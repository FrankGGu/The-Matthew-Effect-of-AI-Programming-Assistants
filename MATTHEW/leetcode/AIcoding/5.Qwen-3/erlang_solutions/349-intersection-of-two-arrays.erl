-module(solution).
-export([intersection/2]).

intersection(A, B) ->
    SetA = sets:from_list(A),
    SetB = sets:from_list(B),
    sets:to_list(sets:intersection(SetA, SetB)).