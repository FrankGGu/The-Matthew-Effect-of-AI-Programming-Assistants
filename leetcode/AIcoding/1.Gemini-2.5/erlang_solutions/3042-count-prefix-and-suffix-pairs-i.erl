-module(solution).
-export([countPrefixSuffixPairs/1]).

-spec countPrefixSuffixPairs(Words :: [unicode:unicode_binary()]) -> integer().
countPrefixSuffixPairs(Words) ->
    count(Words, 0).

count([], Acc) -> Acc;
count([_], Acc) -> Acc;
count([H|T], Acc) ->
    NewAcc = check_pairs_with_head(H, T, Acc),
    count(T, NewAcc).

check_pairs_with_head(_Head, [], Acc) -> Acc;
check_pairs_with_head(Head, [H_T|T_T], Acc) ->
    IsPrefix = binary:starts_with(H_T, Head),
    IsSuffix = binary:ends_with(H_T, Head),
    NewAcc = if IsPrefix andalso IsSuffix -> Acc + 1;
               else -> Acc
             end,
    check_pairs_with_head(Head, T_T, NewAcc).