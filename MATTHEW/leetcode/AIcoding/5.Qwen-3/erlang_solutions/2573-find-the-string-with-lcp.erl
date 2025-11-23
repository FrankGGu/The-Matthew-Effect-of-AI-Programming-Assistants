-module(solution).
-export([lcp_preprocess/1, find_string_with_lcp/2]).

lcp_preprocess(S) ->
    N = erlang:length(S),
    LCP = array:new([{size, N}, {default, 0}]),
    I = 1,
    J = 0,
    K = 0,
    lcp_preprocess_loop(S, I, J, K, LCP).

lcp_preprocess_loop(S, I, J, K, LCP) when I < erlang:length(S) ->
    case erlang:element(I, S) of
        erlang:element(J, S) ->
            K1 = K + 1,
            LCP1 = array:set(I, K1, LCP),
            lcp_preprocess_loop(S, I + 1, J + 1, K1, LCP1);
        _ ->
            if
                J > 0 ->
                    J1 = erlang:element(J, LCP),
                    lcp_preprocess_loop(S, I, J1, 0, LCP);
                true ->
                    lcp_preprocess_loop(S, I + 1, 0, 0, LCP)
            end
    end;
lcp_preprocess_loop(_, _, _, _, LCP) ->
    LCP.

find_string_with_lcp(LCP, K) ->
    N = erlang:length(LCP),
    Result = array:new([{size, N}, {default, $a}]),
    Used = array:new([{size, N}, {default, false}]),
    find_string_with_lcp_loop(0, LCP, K, Result, Used).

find_string_with_lcp_loop(I, LCP, K, Result, Used) when I < erlang:length(LCP) ->
    case erlang:element(I, Used) of
        true ->
            find_string_with_lcp_loop(I + 1, LCP, K, Result, Used);
        false ->
            Char = get_next_char(Result, I, LCP),
            Result1 = array:set(I, Char, Result),
            Used1 = array:set(I, true, Used),
            find_string_with_lcp_loop(I + 1, LCP, K, Result1, Used1)
    end;
find_string_with_lcp_loop(_, _, _, Result, _) ->
    erlang:list_to_binary(array:to_list(Result)).

get_next_char(Result, I, LCP) ->
    MaxChar = $z,
    MinChar = $a,
    get_next_char_loop(MinChar, MaxChar, Result, I, LCP).

get_next_char_loop(Char, MaxChar, Result, I, LCP) when Char > MaxChar ->
    $a;
get_next_char_loop(Char, MaxChar, Result, I, LCP) ->
    case is_valid_char(Result, I, Char, LCP) of
        true ->
            Char;
        false ->
            get_next_char_loop(Char + 1, MaxChar, Result, I, LCP)
    end.

is_valid_char(Result, I, Char, LCP) ->
    N = erlang:length(LCP),
    is_valid_char_loop(0, N - 1, Result, I, Char, LCP).

is_valid_char_loop(J, N, Result, I, Char, LCP) when J >= N ->
    true;
is_valid_char_loop(J, N, Result, I, Char, LCP) ->
    case J of
        I ->
            is_valid_char_loop(J + 1, N, Result, I, Char, LCP);
        _ ->
            LCPVal = erlang:element(J, LCP),
            if
                LCPVal > 0 ->
                    case erlang:element(J, Result) of
                        Char ->
                            is_valid_char_loop(J + 1, N, Result, I, Char, LCP);
                        _ ->
                            false
                    end;
                true ->
                    is_valid_char_loop(J + 1, N, Result, I, Char, LCP)
            end
    end.