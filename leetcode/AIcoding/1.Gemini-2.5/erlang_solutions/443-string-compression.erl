-module(solution).
-export([compress/1]).

compress(Chars) ->
    case Chars of
        [] ->
            {0, []};
        [H|T] ->
            CompressedListRev = compress_helper(T, [], 1, H),
            {length(CompressedListRev), lists:reverse(CompressedListRev)}
    end.

compress_helper([], AccCompressedRev, CurrentCount, CurrentChar) ->
    process_group(CurrentChar, CurrentCount, AccCompressedRev);
compress_helper([H|T], AccCompressedRev, CurrentCount, CurrentChar) ->
    if
        H == CurrentChar ->
            compress_helper(T, AccCompressedRev, CurrentCount + 1, CurrentChar);
        true ->
            NewAccCompressedRev = process_group(CurrentChar, CurrentCount, AccCompressedRev),
            compress_helper(T, NewAccCompressedRev, 1, H)
    end.

process_group(Char, Count, Acc) ->
    Acc1 = [Char | Acc],
    if
        Count > 1 ->
            CountStr = integer_to_list(Count),
            lists:foldl(fun(DigitChar, Acc2) -> [DigitChar | Acc2] end, Acc1, lists:reverse(CountStr));
        true ->
            Acc1
    end.

integer_to_list(N) ->
    lists:reverse(integer_to_list_rev(N, [])).

integer_to_list_rev(0, Acc) ->
    if
        Acc == [] -> [$0];
        true -> Acc
    end;
integer_to_list_rev(N, Acc) when N > 0 ->
    Digit = (N rem 10) + $0,
    integer_to_list_rev(N div 10, [Digit | Acc]).