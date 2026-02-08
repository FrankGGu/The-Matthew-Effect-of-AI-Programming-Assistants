-module(solution).
-export([balanced_string_split/1]).

-spec balanced_string_split(S :: unicode:unicode_binary()) -> integer().
balanced_string_split(S) ->
    StringList = unicode:characters_to_list(S),
    split_balanced_acc(StringList, 0, 0).

split_balanced_acc([], _Balance, Count) ->
    Count;
split_balanced_acc([H | T], Balance, Count) ->
    NewBalance = case H of
                     $L -> Balance + 1;
                     $R -> Balance - 1
                 end,
    NewCount = if NewBalance == 0 -> Count + 1;
               true -> Count
            end,
    split_balanced_acc(T, NewBalance, NewCount).