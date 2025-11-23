-module(solution).
-export([punishment_number/1]).

punishment_number(N) ->
    punishment_number_acc(1, N, 0).

punishment_number_acc(I, N, Acc) when I > N ->
    Acc;
punishment_number_acc(I, N, Acc) ->
    Square = I * I,
    SquareStr = integer_to_list(Square),
    case can_partition_recursive(I, SquareStr) of
        true ->
            punishment_number_acc(I + 1, N, Acc + I);
        false ->
            punishment_number_acc(I + 1, N, Acc)
    end.

can_partition_recursive(Target, StrList) ->
    if
        Target == 0 and StrList == [] -> true;
        Target < 0 -> false;
        StrList == [] -> false;
        true ->
            iterate_prefix_lengths(Target, StrList, 1, length(StrList))
    end.

iterate_prefix_lengths(Target, StrList, CurrentPrefixLen, MaxPrefixLen) when CurrentPrefixLen =< MaxPrefixLen ->
    Prefix = lists:sublist(StrList, CurrentPrefixLen),
    Suffix = lists:nthtail(StrList, CurrentPrefixLen),
    PrefixVal = list_to_integer(Prefix),

    Path1_Success = if
                        PrefixVal =< Target ->
                            can_partition_recursive(Target - PrefixVal, Suffix);
                        true ->
                            false
                    end,

    if Path1_Success ->
        true;
    true ->
        iterate_prefix_lengths(Target, StrList, CurrentPrefixLen + 1, MaxPrefixLen)
    end;
iterate_prefix_lengths(_, _, _, _) ->
    false.