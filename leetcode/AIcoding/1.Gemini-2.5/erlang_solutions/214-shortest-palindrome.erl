-module(shortest_palindrome).
-export([shortest_palindrome/1]).

shortest_palindrome(S) ->
    N = length(S),
    S_rev = lists:reverse(S),
    Combined_list = S ++ "#" ++ S_rev,
    Combined_bin = list_to_binary(Combined_list),

    LPS_list = compute_lps_array(Combined_bin),

    LongestPalindromicPrefixLength = lists:last(LPS_list),

    SuffixToPrepend = lists:sublist(S, LongestPalindromicPrefixLength + 1, N - LongestPalindromicPrefixLength),
    lists:reverse(SuffixToPrepend) ++ S.

compute_lps_array(Pattern_bin) ->
    Len = byte_size(Pattern_bin),
    LPS = array:new([{fixed, true}, {size, Len}]),

    LPS_init = array:set(0, 0, LPS),

    compute_lps_array_loop(Pattern_bin, Len, LPS_init, 0, 1).

compute_lps_array_loop(_Pattern_bin, Len, LPS, _Len_match, I) when I >= Len ->
    array:to_list(LPS);

compute_lps_array_loop(Pattern_bin, Len, LPS, Len_match, I) ->
    P_I = binary:at(Pattern_bin, I),
    P_Len_match = binary:at(Pattern_bin, Len_match),

    if
        P_I == P_Len_match ->
            New_Len_match = Len_match + 1,
            New_LPS = array:set(I, New_Len_match, LPS),
            compute_lps_array_loop(Pattern_bin, Len, New_LPS, New_Len_match, I + 1);
        true ->
            if
                Len_match /= 0 ->
                    Len_match_prev = array:get(Len_match - 1, LPS),
                    compute_lps_array_loop(Pattern_bin, Len, LPS, Len_match_prev, I);
                true ->
                    New_LPS = array:set(I, 0, LPS),
                    compute_lps_array_loop(Pattern_bin, Len, New_LPS, 0, I + 1)
            end
    end.