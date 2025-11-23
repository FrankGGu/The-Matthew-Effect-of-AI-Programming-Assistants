-spec buddy_strings(S :: unicode:unicode_binary(), Goal :: unicode:unicode_binary()) -> boolean().
buddy_strings(S, Goal) ->
    case {byte_size(S), byte_size(Goal)} of
        {Len, Len} ->
            case S =:= Goal of
                true ->
                    case has_duplicate(S) of
                        true -> true;
                        false -> false
                    end;
                false ->
                    case find_mismatches(S, Goal) of
                        {Pos1, Pos2} ->
                            case swap(S, Pos1, Pos2) of
                                Goal -> true;
                                _ -> false
                            end;
                        _ ->
                            false
                    end
            end;
        _ ->
            false
    end.

has_duplicate(S) ->
    has_duplicate(S, #{}).

has_duplicate(<<>>, _) -> false;
has_duplicate(<<C:8, Rest/binary>>, Map) ->
    case maps:is_key(C, Map) of
        true -> true;
        false -> has_duplicate(Rest, Map#{C => true})
    end.

find_mismatches(S, Goal) ->
    find_mismatches(S, Goal, 0, -1, -1).

find_mismatches(<<>>, <<>>, _, Pos1, Pos2) ->
    case {Pos1, Pos2} of
        {-1, -1} -> nomatch;
        {P1, P2} when P1 =/= -1, P2 =/= -1 -> {P1, P2};
        _ -> nomatch
    end;
find_mismatches(<<C1:8, Rest1/binary>>, <<C2:8, Rest2/binary>>, Index, Pos1, Pos2) ->
    if
        C1 =/= C2 ->
            case Pos1 of
                -1 -> find_mismatches(Rest1, Rest2, Index + 1, Index, Pos2);
                _ when Pos2 =:= -1 -> find_mismatches(Rest1, Rest2, Index + 1, Pos1, Index);
                _ -> nomatch
            end;
        true ->
            find_mismatches(Rest1, Rest2, Index + 1, Pos1, Pos2)
    end.

swap(S, Pos1, Pos2) ->
    <<Before:Pos1/binary, C1:8, Middle/binary, C2:8, After/binary>> = S,
    <<Before/binary, C2:8, Middle/binary, C1:8, After/binary>>.