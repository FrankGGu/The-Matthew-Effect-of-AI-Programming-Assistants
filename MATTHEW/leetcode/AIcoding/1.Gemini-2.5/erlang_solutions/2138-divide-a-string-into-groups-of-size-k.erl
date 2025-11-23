-module(solution).
-export([divide_string_into_groups_of_size_k/3]).

divide_string_into_groups_of_size_k(S, K, Fill) ->
    do_divide(S, K, Fill, []).

do_divide(S, K, Fill, Acc) ->
    Len = length(S),
    if
        Len == 0 ->
            lists:reverse(Acc);
        Len >= K ->
            Group = lists:sublist(S, K),
            Rest = lists:nthtail(K, S),
            do_divide(Rest, K, Fill, [Group | Acc]);
        true -> %% Len < K
            PadLen = K - Len,
            PaddedGroup = S ++ lists:duplicate(PadLen, Fill),
            do_divide([], K, Fill, [PaddedGroup | Acc])
    end.