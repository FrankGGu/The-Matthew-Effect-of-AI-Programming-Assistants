-module(solution).
-export([find_longest_word/2]).

-spec find_longest_word(S :: unicode:unicode_binary(), Dictionary :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
find_longest_word(S, Dictionary) ->
    %% Sort the dictionary by length (descending) and lexicographically (ascending)
    SortedDict = lists:sort(fun(A, B) -> 
                               case length(A) - length(B) of
                                 0 -> A < B;
                                 X -> X > 0
                               end
                             end, Dictionary),
    %% Try to find the longest word that can be formed by deleting characters
    lists:foldl(fun(Word, Acc) ->
                    if can_form_word(S, Word) -> Word;
                    true -> Acc
                    end
                end, "", SortedDict).

%% Helper function to check if a word can be formed from S by deleting characters
-spec can_form_word(S :: unicode:unicode_binary(), Word :: unicode:unicode_binary()) -> boolean().
can_form_word(S, Word) ->
    can_form_word(S, Word, 0).

%% Helper function to check if a word can be formed from S using two pointers
-spec can_form_word(S :: unicode:unicode_binary(), Word :: unicode:unicode_binary(), Index :: integer()) -> boolean().
can_form_word([], [], _) -> true;
can_form_word([_|T], [], _) -> true;
can_form_word([], _, _) -> false;
can_form_word([SHead|STail], [WHead|WTail], Index) ->
    if
        SHead =:= WHead -> can_form_word(STail, WTail, Index + 1);
        true -> can_form_word(STail, [WHead|WTail], Index + 1)
    end.
