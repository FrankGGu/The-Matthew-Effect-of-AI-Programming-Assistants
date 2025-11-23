-module(solution).
-export([match_pattern/2]).

match_pattern(Nums, Pattern) ->
    Len = length(Pattern),
    if
        Len == 0 -> 0;
        true -> 
            N = length(Nums),
            P = pattern_to_int(Pattern),
            Count = 0,
            match_pattern(Nums, P, 0, Count)
    end.

pattern_to_int([]) -> [];
pattern_to_int([H|T]) ->
    case H of
        $1 -> [1 | pattern_to_int(T)];
        $0 -> [0 | pattern_to_int(T)]
    end.

match_pattern(_, _, _, Count) when Count >= 0 -> Count;
match_pattern([A,B|T], P, I, Count) ->
    case compare(A, B, lists:nth(I+1, P)) of
        true -> match_pattern([B|T], P, I+1, Count + 1);
        false -> match_pattern([B|T], P, 0, Count)
    end;
match_pattern(_, _, _, Count) -> Count.

compare(X, Y, 1) -> X > Y;
compare(X, Y, 0) -> X == Y.