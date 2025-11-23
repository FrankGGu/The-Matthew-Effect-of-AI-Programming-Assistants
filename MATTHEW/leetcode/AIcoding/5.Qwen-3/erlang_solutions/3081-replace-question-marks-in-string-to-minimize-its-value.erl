-module(solution).
-export([minimize_string/1]).

minimize_string(S) ->
    List = string:to_list(S),
    replace_question_marks(List, 0).

replace_question_marks([], _) ->
    lists:reverse([]);
replace_question_marks([$? | T], Pos) ->
    case Pos of
        0 -> [ $0 | replace_question_marks(T, Pos + 1) ];
        _ -> 
            Prev = lists:nth(Pos, lists:reverse(lists:sublist(List, Pos))),
            Next = if Pos < length(List) - 1 -> lists:nth(Pos + 2, lists:reverse(List)) ; true -> $9 end,
            case Prev of
                $0 -> [ $0 | replace_question_marks(T, Pos + 1) ];
                $9 -> [ $9 | replace_question_marks(T, Pos + 1) ];
                _ -> 
                    MinChar = min_char(Prev, Next),
                    [ MinChar | replace_question_marks(T, Pos + 1) ]
            end
    end;
replace_question_marks([H | T], Pos) ->
    [H | replace_question_marks(T, Pos + 1)].

min_char($0, _) -> $0;
min_char(_, $9) -> $9;
min_char(Prev, Next) when Prev < Next -> Prev;
min_char(Prev, Next) -> Next.