-module(solution).
-export([nextGreatestLetter/2]).

nextGreatestLetter(Letters, Target) ->
    nextGreatestLetter_helper(Letters, Target, hd(Letters)).

nextGreatestLetter_helper([H|_], Target, _OriginalHead) when H > Target ->
    H;
nextGreatestLetter_helper([_|T], Target, OriginalHead) ->
    nextGreatestLetter_helper(T, Target, OriginalHead);
nextGreatestLetter_helper([], _Target, OriginalHead) ->
    OriginalHead.