-module(solution).
-export([find_words/1]).

%% Define the rows of the keyboard.
-define(ROW_1, "qwertyuiop").
-define(ROW_2, "asdfghjkl").
-define(ROW_3, "zxcvbnm").

%% Function to check if a word can be typed on one row of the keyboard.
-spec find_words([unicode:unicode_binary()]) -> [unicode:unicode_binary()].
find_words(Words) ->
    lists:filter(fun(Word) -> can_type_on_one_row(lc:lowercase(Word)) end, Words).

%% Helper function to check if a word can be typed using letters from only one row.
-spec can_type_on_one_row(unicode:unicode_binary()) -> boolean().
can_type_on_one_row(Word) ->
    Row = row_for_letter(lists:first(Word)),
    lists:all(fun(Letter) -> row_for_letter(Letter) =:= Row end, Word).

%% Function to determine which row a letter belongs to.
-spec row_for_letter(char()) -> integer().
row_for_letter(Letter) when Letter >= $a, Letter =< $z ->
    case lists:member(Letter, list_to_charlist(?ROW_1)) of
        true -> 1;
        false -> case lists:member(Letter, list_to_charlist(?ROW_2)) of
            true -> 2;
            false -> 3
        end
    end.
