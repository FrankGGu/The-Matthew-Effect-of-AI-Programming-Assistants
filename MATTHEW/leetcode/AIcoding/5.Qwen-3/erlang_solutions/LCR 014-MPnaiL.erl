-module(solution).
-export([permutation/1]).

permutation(S) ->
    Perms = permute(lists:seq(0, length(S)-1), []),
    [lists:sublist(S, I) || I <- Perms].

permute([], Acc) ->
    [Acc];
permute(Indexes, Acc) ->
    lists:foldl(fun(I, Acc2) ->
        case lists:member(I, Acc) of
            true -> Acc2;
            false -> permute(lists:delete(I, Indexes), [I | Acc])
        end
    end, [], Indexes).