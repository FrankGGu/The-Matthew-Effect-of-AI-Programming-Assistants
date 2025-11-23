-module(solution).
-export([majority_element/1]).

-spec majority_element(Nums :: [integer()]) -> integer().
majority_element([H|T]) ->
    majority_element_bmb(T, H, 1).

majority_element_bmb([], Candidate, _Count) ->
    Candidate;
majority_element_bmb([H|T], Candidate, Count) when H == Candidate ->
    majority_element_bmb(T, Candidate, Count + 1);
majority_element_bmb([NewCandidate|T], _Candidate, 0) ->
    majority_element_bmb(T, NewCandidate, 1);
majority_element_bmb([_H|T], Candidate, Count) ->
    majority_element_bmb(T, Candidate, Count - 1).