-module(solution).
-export([score_of_string/1]).

-spec score_of_string(S :: unicode:unicode_binary()) -> integer().
score_of_string(S) ->
    Chars = unicode:characters_to_list(S),
    score_of_string_list(Chars).

score_of_string_list([]) -> 0;
score_of_string_list([_]) -> 0;
score_of_string_list([H1, H2 | T]) ->
    abs(H1 - H2) + score_of_string_list([H2 | T]).