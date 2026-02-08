-spec letter_case_permutation(S :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
letter_case_permutation(S) ->
    letter_case_permutation(S, 0, []).

letter_case_permutation(<<>>, _Index, Acc) ->
    Acc;
letter_case_permutation(S, Index, []) ->
    <<C:8, Rest/binary>> = S,
    case is_letter(C) of
        true ->
            Lower = string:to_lower(<<C>>),
            Upper = string:to_upper(<<C>>),
            if
                Lower == Upper ->
                    letter_case_permutation(Rest, Index + 1, [<<Lower/binary>>]);
                true ->
                    letter_case_permutation(Rest, Index + 1, [<<Lower/binary>>, <<Upper/binary>>])
            end;
        false ->
            letter_case_permutation(Rest, Index + 1, [<<C>>])
    end;
letter_case_permutation(S, Index, Acc) ->
    <<C:8, Rest/binary>> = S,
    case is_letter(C) of
        true ->
            Lower = string:to_lower(<<C>>),
            Upper = string:to_upper(<<C>>),
            if
                Lower == Upper ->
                    NewAcc = [<<Prefix/binary, Lower/binary>> || <<Prefix/binary>> <- Acc],
                    letter_case_permutation(Rest, Index + 1, NewAcc);
                true ->
                    LowerAcc = [<<Prefix/binary, Lower/binary>> || <<Prefix/binary>> <- Acc],
                    UpperAcc = [<<Prefix/binary, Upper/binary>> || <<Prefix/binary>> <- Acc],
                    letter_case_permutation(Rest, Index + 1, LowerAcc ++ UpperAcc)
            end;
        false ->
            NewAcc = [<<Prefix/binary, C>> || <<Prefix/binary>> <- Acc],
            letter_case_permutation(Rest, Index + 1, NewAcc)
    end.

is_letter(C) ->
    (C >= $a andalso C =< $z) orelse (C >= $A andalso C =< $Z).