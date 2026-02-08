-module(solution).
-export([solve/1]).

solve(S) ->
    Vowels = "aeiou",
    Count = 0,
    Len = erlang:length(S),
    VowelMap = maps:from_list([{C, 0} || C <- Vowels]),
    solve(S, 0, VowelMap, 0, 0, Count).

solve(_, _, _, _, _, Acc) -> Acc;

solve(S, I, VowelMap, J, ConsonantCount, Acc) ->
    if
        J >= erlang:length(S) ->
            solve(S, I+1, VowelMap, I+1, 0, Acc);
        true ->
            C = erlang:element(J+1, S),
            case lists:member(C, "aeiou") of
                true ->
                    NewVowelMap = maps:update(C, maps:get(C, VowelMap)+1, VowelMap),
                    solve(S, I, NewVowelMap, J+1, ConsonantCount, Acc);
                false ->
                    NewConsonantCount = ConsonantCount + 1,
                    if
                        NewConsonantCount > 3 ->
                            solve(S, I, VowelMap, J+1, 0, Acc);
                        true ->
                            solve(S, I, VowelMap, J+1, NewConsonantCount, Acc)
                    end
            end
    end.