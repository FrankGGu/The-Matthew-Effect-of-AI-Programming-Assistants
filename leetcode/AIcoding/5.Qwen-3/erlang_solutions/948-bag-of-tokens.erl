-module(bag_of_tokens).
-export([bag_of_tokens/1]).

bag_of_tokens(Tokens) ->
    bag_of_tokens(Tokens, 0, 0, 0).

bag_of_tokens([], _, MaxScore, _) ->
    MaxScore;
bag_of_tokens([Token | Rest], Score, MaxScore, Power) when Token =< Power ->
    bag_of_tokens(Rest, Score + 1, max(MaxScore, Score + 1), Power - Token);
bag_of_tokens([Token | Rest], Score, MaxScore, Power) ->
    if
        Score > 0 ->
            bag_of_tokens(Rest, Score - 1, MaxScore, Power + Token);
        true ->
            MaxScore
    end.