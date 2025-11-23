-module(solution).
-export([word_ladder/2]).

word_ladder(Start, End) ->
    word_ladder(Start, End, [Start], lists:seq(1, length(Start))).

word_ladder(_, End, Visited, _) when End in Visited ->
    length(Visited) - 1;
word_ladder(Start, End, Visited, Lengths) ->
    lists:foldl(fun(Idx, Acc) ->
        case transform(Visited, Start, Idx) of
            [] -> Acc;
            NewVisited -> 
                case word_ladder(NewVisited, End, lists:append(Visited, NewVisited), Lengths) of
                    undefined -> Acc;
                    Result -> Result
                end
        end
    end, undefined, Lengths).

transform(Visited, Start, Idx) ->
    lists:filter(fun(W) -> valid_word(W, Start, Visited) end, lists:map(fun(Word) -> replace_char(Word, Start, Idx) end, Visited)).

valid_word(W, Start, Visited) ->
    W /= Start andalso not lists:member(W, Visited).

replace_char(W, Start, Idx) ->
    case string:to_list(W) of
        [H | T] -> [H | lists:nthtail(Idx, string:to_list(Start))];
        _ -> []
    end.