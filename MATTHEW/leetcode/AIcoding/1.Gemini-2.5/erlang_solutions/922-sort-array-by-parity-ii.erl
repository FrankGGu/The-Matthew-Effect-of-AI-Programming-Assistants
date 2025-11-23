-module(solution).
-export([sort_array_by_parity_ii/1]).

sort_array_by_parity_ii(A) ->
    {EvensRev, OddsRev} = lists:foldl(
        fun(X, {Es, Os}) ->
            case X rem 2 of
                0 -> {[X|Es], Os};
                1 -> {Es, [X|Os]}
            end
        end,
        {[], []},
        A
    ),
    Evens = lists:reverse(EvensRev),
    Odds = lists:reverse(OddsRev),
    interleave(Evens, Odds).

interleave([], []) -> [];
interleave([He|Te], [Ho|To]) ->
    [He, Ho | interleave(Te, To)].