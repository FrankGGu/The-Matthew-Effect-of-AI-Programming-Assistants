-module(repeat_limit).
-export([repeat_limited_string/2]).

repeat_limited_string(Counts, RepeatLimit) ->
    List = lists:zipwith(fun(I, C) -> {I, C} end, lists:seq($a, $z), Counts),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, List),
    repeat_limited_string(Sorted, "", 0, []).

repeat_limited_string([], Result, _, _) ->
    Result;
repeat_limited_string([{Char, Count} | Rest], Result, Limit, Previous) ->
    if
        Limit < RepeatLimit ->
            NewResult = Result ++ [Char],
            NewCount = Count - 1,
            if
                NewCount > 0 ->
                    repeat_limited_string([{Char, NewCount} | Rest], NewResult, Limit + 1, [{Char, NewCount} | Previous]);
                true ->
                    repeat_limited_string(Rest, NewResult, 0, Previous)
            end;
        true ->
            case Previous of
                [] ->
                    repeat_limited_string(Rest, Result, 0, Previous);
                _ ->
                    [First | RestPrevious] = Previous,
                    NewResult = Result ++ [First],
                    NewCount = First#{} - 1,
                    repeat_limited_string([{First, NewCount} | Rest], NewResult, 1, RestPrevious)
            end
    end.