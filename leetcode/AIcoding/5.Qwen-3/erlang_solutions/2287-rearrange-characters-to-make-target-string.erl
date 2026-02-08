-module(rearrange_characters).
-export([count_possible_strings/2]).

count_possible_strings(Chars, Target) ->
    Count = count_chars(Chars),
    TargetCount = count_chars(Target),
    find_max_repeats(Count, TargetCount).

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) -> dict:update_counter(Char, 1, Acc) end, dict:new(), Str).

find_max_repeats(_, _) when [] == dict:to_list(dict:filter(fun(_, V) -> V > 0 end, dict:subtract(dict:from_list([]), dict:from_list([])))) ->
    0;
find_max_repeats(Count, TargetCount) ->
    MaxRepeats = lists:foldl(fun({Char, TargetQty}, Acc) ->
        case dict:is_key(Char, Count) of
            true ->
                AvailableQty = dict:fetch(Char, Count),
                Repeats = AvailableQty div TargetQty,
                min(Acc, Repeats);
            false ->
                0
        end
    end, infinity, dict:to_list(TargetCount)),
    MaxRepeats.