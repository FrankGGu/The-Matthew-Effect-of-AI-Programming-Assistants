-module(min_moves_to_make_array_complementary).
-export([minMoves/1]).

minMoves(Numbers) ->
    N = length(Numbers),
    Min = 0,
    Max = 2 * 10^5,
    Count = array:new(Max + 1, {default, 0}),
    process_pairs(Numbers, 0, N - 1, Count),
    compute_min_moves(Numbers, Count).

process_pairs(_, I, J, _) when I >= J -> ok;
process_pairs(Numbers, I, J, Count) ->
    A = lists:nth(I + 1, Numbers),
    B = lists:nth(J + 1, Numbers),
    Target = A + B,
    Count1 = array:set(Target, array:get(Target, Count) + 1, Count),
    process_pairs(Numbers, I + 1, J - 1, Count1).

compute_min_moves(Numbers, Count) ->
    N = length(Numbers),
    Min = 0,
    Max = 2 * 10^5,
    compute_min_moves(Numbers, Count, 0, Min, Max).

compute_min_moves(_, _, Target, Min, Max) when Target > Max -> Min;
compute_min_moves(Numbers, Count, Target, Min, Max) ->
    Current = array:get(Target, Count),
    Required = (length(Numbers) - Current) / 2,
    NewMin = if Required < Min -> Required; true -> Min end,
    compute_min_moves(Numbers, Count, Target + 1, NewMin, Max).