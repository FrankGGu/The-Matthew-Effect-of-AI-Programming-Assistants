-spec k_inverse_pairs(N :: integer(), K :: integer()) -> integer().
k_inverse_pairs(N, K) ->
    Mod = 1000000007,
    if 
        K < 0 -> 0;
        K == 0 -> 1;
        K > N * (N - 1) div 2 -> 0;
        true ->
            DP = lists:duplicate(K + 1, 0),
            DP1 = setelement(1, DP, 1),
            DP2 = solve(2, N, K, DP1, Mod),
            element(K + 1, DP2)
    end.

solve(I, N, K, PrevDP, Mod) when I =< N ->
    CurrDP = lists:duplicate(K + 1, 0),
    CurrDP1 = setelement(1, CurrDP, 1),
    CurrDP2 = compute_row(1, K, I, PrevDP, CurrDP1, Mod),
    solve(I + 1, N, K, CurrDP2, Mod);
solve(_, _, _, DP, _) -> DP.

compute_row(J, K, I, PrevDP, CurrDP, Mod) when J =< K ->
    Val = if
               J >= I -> (element(J + 1, CurrDP) + element(J + 1 - I, PrevDP)) rem Mod;
               true -> (element(J + 1, CurrDP) + element(J + 1, PrevDP)) rem Mod
           end,
    CurrDP1 = setelement(J + 1, CurrDP, Val),
    compute_row(J + 1, K, I, PrevDP, CurrDP1, Mod);
compute_row(_, _, _, _, CurrDP, _) -> CurrDP.