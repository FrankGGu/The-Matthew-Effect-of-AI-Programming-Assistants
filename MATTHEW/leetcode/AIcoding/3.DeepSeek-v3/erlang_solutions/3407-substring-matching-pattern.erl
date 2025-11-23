-module(solution).
-export([word_pattern/2]).

word_pattern(Pattern, Str) ->
    Words = string:tokens(Str, " "),
    case length(Pattern) =:= length(Words) of
        false -> false;
        true ->
            P2W = maps:new(),
            W2P = maps:new(),
            check_pattern(Pattern, Words, P2W, W2P)
    end.

check_pattern([], [], _, _) -> true;
check_pattern([P|Ps], [W|Ws], P2W, W2P) ->
    case {maps:get(P, P2W, undefined), maps:get(W, W2P, undefined)} of
        {undefined, undefined} ->
            NewP2W = maps:put(P, W, P2W),
            NewW2P = maps:put(W, P, W2P),
            check_pattern(Ps, Ws, NewP2W, NewW2P);
        {W, P} ->
            check_pattern(Ps, Ws, P2W, W2P);
        _ -> false
    end.