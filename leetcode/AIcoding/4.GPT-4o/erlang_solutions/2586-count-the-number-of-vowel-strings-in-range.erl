-module(solution).
-export([vowel_strings/3]).

vowel_strings(Strs, L, R) ->
    lists:foldl(fun(S, Acc) -> 
        if 
            string:length(S) >= L andalso string:length(S) =< R andalso is_vowel_string(S) ->
                Acc + 1;
            true ->
                Acc
        end
    end, 0, Strs).

is_vowel_string(Str) ->
    lists:all(fun(C) -> C =:= $a orelse C =:= $e orelse C =:= $i orelse C =:= $o orelse C =:= $u end, string:to_lower(Str)).