-module(solution).
-export([solve/1]).

is_anagram(Word1, Word2) ->
    lists:sort(Word1) == lists:sort(Word2).

solve(Words) ->
    solve(Words, []).

solve([H | T], Acc) ->
    case Acc of
        [] ->
            solve(T, [H]);
        [LastWord | _] ->
            if is_anagram(H, LastWord) ->
                    solve(T, Acc);
                true ->
                    solve(T, [H | Acc])
            end
    end;
solve([], Acc) ->
    lists:reverse(Acc).