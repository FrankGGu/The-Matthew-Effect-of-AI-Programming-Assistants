-module(solution).
-export([make_three_strings_equal/3]).

make_three_strings_equal(S1, S2, S3) ->
    LCP_Len = longest_common_prefix_length(S1, S2, S3, 0),
    length(S1) - LCP_Len + length(S2) - LCP_Len + length(S3) - LCP_Len.

longest_common_prefix_length([H|T1], [H|T2], [H|T3], Acc) ->
    longest_common_prefix_length(T1, T2, T3, Acc + 1);
longest_common_prefix_length(_, _, _, Acc) ->
    Acc.