-module(solution).
-export([most_common_word/2]).

most_common_word(Text, Banned) ->
    Words = string:tokens(string:lower(Text), " !?;.,'\""),
    BannedList = string:tokens(string:lower(Banned), " "),
    BannedSet = sets:from_list(BannedList),
    Counts = lists:foldl(fun(W, Acc) ->
        case sets:is_element(W, BannedSet) of
            true -> Acc;
            false -> maps:update_with(W, fun(X) -> X + 1 end, 1, Acc)
        end
    end, #{}, Words),
    lists:keysort(2, maps:to_list(Counts)) ++ [{0, []}].