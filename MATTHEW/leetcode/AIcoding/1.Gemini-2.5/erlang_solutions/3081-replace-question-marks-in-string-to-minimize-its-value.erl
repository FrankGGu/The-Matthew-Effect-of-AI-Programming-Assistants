-module(solution).
-export([replace_question_marks/1]).

replace_question_marks(S) ->
    lists:map(fun(Char) ->
                      if Char == $? -> $a;
                         true -> Char
                      end
              end, S).