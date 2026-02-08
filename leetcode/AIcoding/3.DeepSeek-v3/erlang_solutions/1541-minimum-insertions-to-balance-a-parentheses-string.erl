-spec min_insertions(S :: unicode:unicode_binary()) -> integer().
min_insertions(S) ->
    min_insertions(S, 0, 0).

min_insertions(<<>>, Open, Ans) ->
    Ans + 2 * Open;
min_insertions(<<$(, Rest/binary>>, Open, Ans) ->
    min_insertions(Rest, Open + 1, Ans);
min_insertions(<<$), Rest/binary>>, Open, Ans) ->
    case Open of
        0 ->
            min_insertions(Rest, Open, Ans + 1);
        _ ->
            case Rest of
                <<$), Rest1/binary>> ->
                    min_insertions(Rest1, Open - 1, Ans);
                _ ->
                    min_insertions(Rest, Open - 1, Ans + 1)
            end
    end.