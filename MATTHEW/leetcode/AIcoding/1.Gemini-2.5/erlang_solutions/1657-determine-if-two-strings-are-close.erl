-module(solution).
-export([closeStrings/2]).

-spec closeStrings(Word1 :: unicode:unicode_binary() | unicode:unicode_charlist(), Word2 :: unicode:unicode_binary() | unicode:unicode_charlist()) -> boolean().
closeStrings(Word1, Word2) ->
    Len1 = length(Word1),
    Len2 = length(Word2),
    if Len1 =/= Len2 -> false;
       true ->
            Counts1 = get_counts(Word1),
            Counts2 = get_counts(Word2),

            Chars1 = lists:sort(maps:keys(Counts1)),
            Chars2 = lists:sort(maps:keys(Counts2)),

            if Chars1 =/= Chars2 -> false;
               true ->
                    Frequencies1 = lists:sort(maps:values(Counts1)),
                    Frequencies2 = lists:sort(maps:values(Counts2)),

                    Frequencies1 =:= Frequencies2
            end
    end.

get_counts(String) ->
    lists:foldl(fun(Char, Acc) ->
                    maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
                end, maps:new(), String).