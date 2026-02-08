-module(solution).
-export([canMakeSubsequence/2]).

canMakeSubsequence(Source, Target) ->
    canMakeSubsequence(Source, Target, 0, 0).

canMakeSubsequence(_, _, TPos, _) when TPos == length(Target) -> true;
canMakeSubsequence(_, _, _, SPos) when SPos == length(Source) -> false;
canMakeSubsequence(Source, Target, TPos, SPos) ->
    SChar = lists:nth(SPos + 1, Source),
    TChar = lists:nth(TPos + 1, Target),
    case isCyclicIncrement(SChar, TChar) of
        true ->
            canMakeSubsequence(Source, Target, TPos + 1, SPos + 1);
        false ->
            canMakeSubsequence(Source, Target, TPos, SPos + 1)
    end.

isCyclicIncrement(A, B) ->
    AVal = erlang:element(2, erlang:binary_to_term(erlang:list_to_binary([A]))),
    BVal = erlang:element(2, erlang:binary_to_term(erlang:list_to_binary([B]))),
    Diff = (BVal - AVal + 26) rem 26,
    Diff =< 1.