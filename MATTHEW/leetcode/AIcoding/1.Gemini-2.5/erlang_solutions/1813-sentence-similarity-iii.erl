-module(solution).
-export([sentenceSimilarity/2]).

sentenceSimilarity(Sentence1, Sentence2) ->
    Len1 = length(Sentence1),
    Len2 = length(Sentence2),

    if Len1 > Len2 ->
        sentenceSimilarity(Sentence2, Sentence1);
    true ->
        check_similarity(Sentence1, Sentence2, Len1)
    end.

find_common_prefix_and_rem([], L2, AccLen) -> {AccLen, [], L2};
find_common_prefix_and_rem(L1, [], AccLen) -> {AccLen, L1, []};
find_common_prefix_and_rem([H1|T1], [H2|T2], AccLen) when H1 == H2 ->
    find_common_prefix_and_rem(T1, T2, AccLen + 1);
find_common_prefix_and_rem(L1, L2, AccLen) ->
    {AccLen, L1, L2}.

check_similarity(S1, S2, Len1) ->
    {PrefixLen, S1_rem_prefix, S2_rem_prefix} = find_common_prefix_and_rem(S1, S2, 0),

    if PrefixLen == Len1 ->
        true;
    true ->
        RemainingS1Len = Len1 - PrefixLen,

        S1_rev = lists:reverse(S1_rem_prefix),
        S2_rev = lists:reverse(S2_rem_prefix),

        {SuffixLen, _S1_rem_suffix_rev, _S2_rem_suffix_rev} = find_common_prefix_and_rem(S1_rev, S2_rev, 0),

        SuffixLen == RemainingS1Len
    end.