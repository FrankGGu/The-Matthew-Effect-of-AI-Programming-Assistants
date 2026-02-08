-module(solution).
-export([place_word_in_crossword/2]).

place_word_in_crossword(Board, Word) ->
    M = length(Board),
    N = length(hd(Board)),
    WordLen = length(Word),
    check_all_slots(Board, Word, M, N, WordLen).

check_all_slots(Board, Word, M, N, WordLen) ->
    lists:any(fun(R) ->
        lists:any(fun(C) ->
            (check_horizontal_slot(Board, Word, M, N, WordLen, R, C) orelse
             check_vertical_slot(Board, Word, M, N, WordLen, R, C))
        end, lists:seq(0, N-1))
    end, lists:seq(0, M-1)).

get_char(Board, R, C, M, N) when R >= 0, R < M, C >= 0, C < N ->
    lists:nth(C + 1, lists:nth(R + 1, Board));
get_char(_Board, _R, _C, _M, _N) ->
    $#.

can_fit_word(SlotChars, WordChars) ->
    length(SlotChars) == length(WordChars) andalso
    (check_match(SlotChars, WordChars) orelse check_match(SlotChars, lists:reverse(WordChars))).

check_match([], []) ->
    true;
check_match([S|Ss], [W|Ws]) ->
    (S == $  orelse S == W) andalso check_match(Ss, Ws);
check_match(_, _) ->
    false.

check_horizontal_slot(Board, Word, M, N, WordLen, R, C) ->
    case get_char(Board, R, C - 1, M, N) of
        $# ->
            {C_end, SlotChars} = find_horizontal_slot_chars(Board, R, C, M, N),
            SlotLen = C_end - C,
            SlotLen == WordLen andalso can_fit_word(SlotChars, Word);
        _ ->
            false
    end.

find_horizontal_slot_chars(Board, R, C_start, M, N) ->
    find_horizontal_slot_chars_recursive(Board, R, C_start, M, N, []).

find_horizontal_slot_chars_recursive(Board, R, C, M, N, Acc) when C < N ->
    Char = get_char(Board, R, C, M, N),
    case Char of
        $# ->
            {C, lists:reverse(Acc)};
        _ ->
            find_horizontal_slot_chars_recursive(Board, R, C + 1, M, N, [Char|Acc])
    end;
find_horizontal_slot_chars_recursive(_Board, _R, C, _M, _N, Acc) ->
    {C, lists:reverse(Acc)}.

check_vertical_slot(Board, Word, M, N, WordLen, R, C) ->
    case get_char(Board, R - 1, C, M, N) of
        $# ->
            {R_end, SlotChars} = find_vertical_slot_chars(Board, R, C, M, N),
            SlotLen = R_end - R,
            SlotLen == WordLen andalso can_fit_word(SlotChars, Word);
        _ ->
            false
    end.

find_vertical_slot_chars(Board, R_start, C, M, N) ->
    find_vertical_slot_chars_recursive(Board, R_start, C, M, N, []).

find_vertical_slot_chars_recursive(Board, R, C, M, N, Acc) when R < M ->
    Char = get_char(Board, R, C, M, N),
    case Char of
        $# ->
            {R, lists:reverse(Acc)};
        _ ->
            find_vertical_slot_chars_recursive(Board, R + 1, C, M, N, [Char|Acc])
    end;
find_vertical_slot_chars_recursive(_Board, R, _C, _M, _N, Acc) ->
    {R, lists:reverse(Acc)}.