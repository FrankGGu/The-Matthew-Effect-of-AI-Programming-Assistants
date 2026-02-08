-module(solution).
-export([lastVisitedIntegers/1]).

lastVisitedIntegers(Words) ->
    lists:reverse(process_words(Words, [], 0, [])).

process_words([], _Visited, _PrevCount, AccResults) ->
    AccResults;
process_words([Word | Rest], Visited, PrevCount, AccResults) ->
    case Word of
        "prev" ->
            NewPrevCount = PrevCount + 1,
            Result =
                if
                    NewPrevCount > length(Visited) ->
                        -1;
                    true ->
                        lists:nth(NewPrevCount, Visited)
                end,
            process_words(Rest, Visited, NewPrevCount, [Result | AccResults]);
        _ -> % It's a number string
            Num = binary_to_integer(list_to_binary(Word)),
            NewVisited = [Num | Visited],
            process_words(Rest, NewVisited, 0, AccResults)
    end.