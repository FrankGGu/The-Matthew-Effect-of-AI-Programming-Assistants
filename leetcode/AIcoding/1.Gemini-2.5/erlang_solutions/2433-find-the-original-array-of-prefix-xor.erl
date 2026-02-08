-module(solution).
-export([findTheOriginalArrayOfPrefixXor/1]).

findTheOriginalArrayOfPrefixXor([P0 | PrefTail]) ->
    [P0 | findTheOriginalArrayOfPrefixXor_helper(P0, PrefTail)].

findTheOriginalArrayOfPrefixXor_helper(PrevPrefVal, [CurrentPrefVal | Rest]) ->
    CurrentArrVal = CurrentPrefVal bxor PrevPrefVal,
    [CurrentArrVal | findTheOriginalArrayOfPrefixXor_helper(CurrentPrefVal, Rest)];
findTheOriginalArrayOfPrefixXor_helper(_, []) ->
    [].