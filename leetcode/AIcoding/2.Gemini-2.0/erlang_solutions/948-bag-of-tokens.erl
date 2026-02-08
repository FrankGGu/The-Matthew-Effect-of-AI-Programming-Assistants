-module(bag_of_tokens).
-export([bag_of_tokens/1]).

bag_of_tokens(Tokens) ->
    bag_of_tokens(Tokens, 0, 0, lists:sort(Tokens)).

bag_of_tokens([], Score, _, _) ->
    Score;
bag_of_tokens([H|T], Score, Power, Tokens) when H =:= hd(Tokens) ->
    if
        Power >= H ->
            bag_of_tokens(T, Score + 1, Power - H, tl(Tokens));
        true ->
            Score
    end;
bag_of_tokens(Tokens, Score, Power, SortedTokens) ->
    if
        length(Tokens) > 1 ->
            if
                Score > 0 ->
                    bag_of_tokens(lists:sublist(Tokens, 1, length(Tokens) - 1), Score - 1, Power + lists:last(Tokens), lists:sublist(SortedTokens, 1, length(SortedTokens) - 1));
                true ->
                    Score
            end;
        true ->
            Score
    end.