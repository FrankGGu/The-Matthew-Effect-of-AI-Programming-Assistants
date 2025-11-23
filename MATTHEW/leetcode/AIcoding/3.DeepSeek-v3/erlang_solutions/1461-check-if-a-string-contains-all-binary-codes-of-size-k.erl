-spec has_all_codes(S :: unicode:unicode_binary(), K :: integer()) -> boolean().
has_all_codes(S, K) ->
    case K of
        0 -> true;
        _ ->
            Len = length(S),
            if
                Len < K -> false;
                true ->
                    Total = 1 bsl K,
                    Set = sets:new(),
                    Set1 = collect_codes(S, K, 0, 0, Set),
                    sets:size(Set1) == Total
            end
    end.

collect_codes(S, K, Index, Current, Set) when Index < K ->
    <<_:Index/binary, Bit:1/integer, _/binary>> = S,
    collect_codes(S, K, Index + 1, (Current bsl 1) bor Bit, Set);
collect_codes(S, K, Index, Current, Set) ->
    Len = byte_size(S),
    if
        Index == Len -> sets:add_element(Current, Set);
        true ->
            <<_:Index/binary, Bit:1/integer, _/binary>> = S,
            NewCurrent = ((Current bsl 1) band ((1 bsl K) - 1)) bor Bit,
            collect_codes(S, K, Index + 1, NewCurrent, sets:add_element(Current, Set))
    end.