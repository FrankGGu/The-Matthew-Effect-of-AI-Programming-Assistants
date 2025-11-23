-module(solution).
-export([minimize_string_value/1]).

minimize_string_value(S) ->
    SList = unicode:characters_to_list(S),
    {Qs, Chars} = lists:partition(fun(C) -> C =:= $? end, SList),
    Counts = count_chars(Chars),
    NewChars = fill_qs(Qs, Counts),
    replace_qs(SList, NewChars).

count_chars(Chars) ->
    lists:foldl(fun(C, Acc) -> 
        maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
    end, maps:new(), Chars).

fill_qs([], _) -> [];
fill_qs(Qs, Counts) ->
    fill_qs(Qs, Counts, []).

fill_qs([], _, Acc) -> lists:reverse(Acc);
fill_qs(Qs, Counts, Acc) ->
    MinChar = find_min_char(Counts),
    NewCounts = maps:update_with(MinChar, fun(V) -> V + 1 end, 1, Counts),
    fill_qs(tl(Qs), NewCounts, [MinChar | Acc]).

find_min_char(Counts) ->
    lists:min([C || C <- lists:seq($a, $z), 
                    not maps:is_key(C, Counts) orelse maps:get(C, Counts) =:= 0]).

replace_qs([], _) -> [];
replace_qs([$? | Rest], [H | T]) -> [H | replace_qs(Rest, T)];
replace_qs([C | Rest], NewChars) -> [C | replace_qs(Rest, NewChars)].