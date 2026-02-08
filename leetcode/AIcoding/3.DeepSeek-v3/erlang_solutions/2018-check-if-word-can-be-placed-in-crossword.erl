-spec place_word_in_crossword(Board :: [[char()]], Word :: unicode:unicode_binary()) -> boolean().
place_word_in_crossword(Board, Word) ->
    M = length(Board),
    N = length(hd(Board)),
    WordList = unicode:characters_to_list(Word),
    Len = length(WordList),
    case check_rows(Board, M, N, WordList, Len) of
        true -> true;
        false -> check_cols(Board, M, N, WordList, Len)
    end.

check_rows(Board, M, N, Word, Len) ->
    check_rows(Board, M, N, Word, Len, 0).

check_rows(_, M, _, _, _, I) when I >= M -> false;
check_rows(Board, M, N, Word, Len, I) ->
    Row = lists:nth(I + 1, Board),
    case check_line(Row, N, Word, Len) of
        true -> true;
        false -> check_rows(Board, M, N, Word, Len, I + 1)
    end.

check_cols(Board, M, N, Word, Len) ->
    check_cols(Board, M, N, Word, Len, 0).

check_cols(_, _, N, _, _, J) when J >= N -> false;
check_cols(Board, M, N, Word, Len, J) ->
    Col = [lists:nth(J + 1, lists:nth(I + 1, Board)) || I <- lists:seq(0, M - 1)],
    case check_line(Col, M, Word, Len) of
        true -> true;
        false -> check_cols(Board, M, N, Word, Len, J + 1)
    end.

check_line(Line, Size, Word, Len) ->
    check_line(Line, Size, Word, Len, 0, []).

check_line(_, _, _, Len, Start, _) when Start + Len > length(Line) -> false;
check_line(Line, Size, Word, Len, Start, Acc) ->
    case extract_segment(Line, Start, Len) of
        {ok, Segment} ->
            case matches(Segment, Word) of
                true -> true;
                false -> check_line(Line, Size, Word, Len, Start + 1, Acc)
            end;
        error -> check_line(Line, Size, Word, Len, Start + 1, Acc)
    end.

extract_segment(Line, Start, Len) ->
    case Start + Len =< length(Line) of
        true ->
            Segment = lists:sublist(Line, Start + 1, Len),
            case valid_segment(Segment) of
                true -> {ok, Segment};
                false -> error
            end;
        false -> error
    end.

valid_segment(Segment) ->
    lists:all(fun(C) -> C =:= $  orelse C =/= $# end, Segment).

matches(Segment, Word) ->
    matches_forward(Segment, Word) orelse matches_backward(Segment, Word).

matches_forward(Segment, Word) ->
    lists:all(fun({C, W}) -> C =:= $  orelse C =:= W end, lists:zip(Segment, Word)).

matches_backward(Segment, Word) ->
    matches_forward(lists:reverse(Segment), Word).