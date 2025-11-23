-module(solution).
-export([minimize_value/1]).

minimize_value(Str) ->
    StrList = string:to_list(Str),
    MinValueList = replace_question_marks(StrList),
    string:from_list(MinValueList).

replace_question_marks([]) -> [];
replace_question_marks([$?|T]) -> [$0 | replace_question_marks(T)];
replace_question_marks([H | T]) -> [H | replace_question_marks(T)].