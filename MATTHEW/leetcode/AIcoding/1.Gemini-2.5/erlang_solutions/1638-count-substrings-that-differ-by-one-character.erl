-module(solution).
-export([countSubstrings/2]).

-spec countSubstrings(S :: unicode:chardata(), T :: unicode:chardata()) -> integer().
countSubstrings(S_in, T_in) ->
    S_list = unicode:characters_to_list(S_in),
    T_list = unicode:characters_to_list(T_in),
    S_len = length(S_list),
    T_len = length(T_list),
    count_all_pairs(S_list, S_len, T_list, T_len, 0, 0, 0).

count_all_pairs(_S, S_len, _T, _T_len, S_idx, _T_idx, Acc) when S_idx >= S_len ->
    Acc;
count_all_pairs(S, S_len, T, T_len, S_idx, T_idx, Acc) when T_idx >= T_len ->
    count_all_pairs(S, S_len, T, T_len, S_idx + 1, 0, Acc);
count_all_pairs(S, S_len, T, T_len, S_idx, T_idx, Acc) ->
    SubS = lists:nthtail(S_idx, S),
    SubT = lists:nthtail(T_idx, T),
    NewAcc = count_for_fixed_start(SubS, SubT, Acc, 0),
    count_all_pairs(S, S_len, T, T_len, S_idx, T_idx + 1, NewAcc).

count_for_fixed_start([], _T_sub, Acc, _DiffCount) -> Acc;
count_for_fixed_start(_S_sub, [], Acc, _DiffCount) -> Acc;
count_for_fixed_start([Sh | St], [Th | Tt], Acc, DiffCount) ->
    NewDiffCount = DiffCount + (if Sh =:= Th -> 0; true -> 1 end),
    NewAcc = if NewDiffCount =:= 1 -> Acc + 1; true -> Acc end,
    count_for_fixed_start(St, Tt, NewAcc, NewDiffCount).