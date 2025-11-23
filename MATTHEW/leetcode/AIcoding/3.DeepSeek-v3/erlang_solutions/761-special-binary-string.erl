-spec make_largest_special(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
make_largest_special(S) ->
    case S of
        <<>> -> <<>>;
        _ ->
            {Result, _} = process(S, 0, 0, []),
            Result
    end.

process(<<>>, _Count, _I, Acc) ->
    {lists:foldl(fun(E, A) -> <<A/binary, (make_largest_special(E))/binary>> end, <<>>, lists:sort(fun(A, B) -> A > B end, Acc)), 0};
process(<<$1, Rest/binary>>, Count, I, Acc) ->
    process(Rest, Count + 1, I + 1, Acc);
process(<<$0, Rest/binary>>, Count, I, Acc) when Count > 0 ->
    case Count - 1 of
        0 ->
            {Sub, NewI} = process(Rest, 0, I + 1, []),
            process(Sub, 0, NewI, [<<$1, (binary:part(S, I, NewI - I))/binary, $0>> | Acc]);
        NewCount ->
            process(Rest, NewCount, I + 1, Acc)
    end;
process(<<_, Rest/binary>>, Count, I, Acc) ->
    process(Rest, Count, I + 1, Acc).