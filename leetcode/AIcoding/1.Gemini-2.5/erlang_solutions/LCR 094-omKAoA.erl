-module(solution).
-export([min_cut/1]).

min_cut(S) ->
    N = string:len(S),
    S_binary = unicode:characters_to_binary(S),

    IsPal = precompute_palindromes(N, S_binary, maps:new()),

    DP = compute_dp(N, IsPal, maps:put(0, 0, maps:new())),

    maps:get(N, DP).

precompute_palindromes(N, S_binary, IsPal0) ->
    precompute_palindromes_len(1, N, S_binary, IsPal0).

precompute_palindromes_len(Len, N, S_binary, IsPal0) when Len =< N ->
    IsPal1 = precompute_palindromes_idx(0, Len, N, S_binary, IsPal0),
    precompute_palindromes_len(Len + 1, N, S_binary, IsPal1);
precompute_palindromes_len(_Len, _N, _S_binary, IsPal) ->
    IsPal.

precompute_palindromes_idx(I, Len, N, S_binary, IsPal0) when I =< N - Len ->
    J = I + Len - 1,
    IsPalindrome = 
        if
            Len == 1 ->
                true;
            Len == 2 ->
                binary:at(S_binary, I) == binary:at(S_binary, J);
            true ->
                binary:at(S_binary, I) == binary:at(S_binary, J) andalso maps:get({I + 1, J - 1}, IsPal0)
        end,
    IsPal1 = maps:put({I, J}, IsPalindrome, IsPal0),
    precompute_palindromes_idx(I + 1, Len, N, S_binary, IsPal1);
precompute_palindromes_idx(_I, _Len, _N, _S_binary, IsPal) ->
    IsPal.

compute_dp(N, IsPal, DP0) ->
    compute_dp_i(1, N, IsPal, DP0).

compute_dp_i(I, N, IsPal, DP0) when I =< N ->
    MinCutsForI = I - 1,

    MinCutsForI_updated = compute_dp_j(0, I, IsPal, DP0, MinCutsForI),

    DP1 = maps:put(I, MinCutsForI_updated, DP0),
    compute_dp_i(I + 1, N, IsPal, DP1);
compute_dp_i(_I, _N, _IsPal, DP) ->
    DP.

compute_dp_j(J, I, IsPal, DP, CurrentMinCuts) when J < I ->
    IsPalindrome = maps:get({J, I - 1}, IsPal),

    NewMinCuts = 
        if 
            IsPalindrome ->
                if 
                    J == 0 ->
                        0;
                    true ->
                        PrevCuts = maps:get(J, DP),
                        min(CurrentMinCuts, PrevCuts + 1)
                end;
            true ->
                CurrentMinCuts
        end,

    if 
        NewMinCuts == 0 ->
            0;
        true ->
            compute_dp_j(J + 1, I, IsPal, DP, NewMinCuts)
    end;
compute_dp_j(_J, _I, _IsPal, _DP, CurrentMinCuts) ->
    CurrentMinCuts.