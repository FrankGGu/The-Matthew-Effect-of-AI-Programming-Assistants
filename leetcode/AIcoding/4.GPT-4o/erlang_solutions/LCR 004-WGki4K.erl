-module(solution).
-export([single_number/1]).

single_number(List) ->
    single_number(List, 0, 0).

single_number([], Result, _) ->
    Result;
single_number([H | T], Result, Seen) ->
    NewSeen = Seen bxor H,
    NewResult = (Result + H) band (not Seen) bxor (not NewSeen),
    single_number(T, NewResult, NewSeen).