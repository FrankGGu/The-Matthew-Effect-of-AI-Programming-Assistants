-spec bag_of_tokens_score(Tokens :: [integer()], Power :: integer()) -> integer().
bag_of_tokens_score(Tokens, Power) ->
    Sorted = lists:sort(Tokens),
    bag_of_tokens_score(Sorted, Power, 0, 0, length(Sorted) - 1).

bag_of_tokens_score(_, _, Score, Left, Right) when Left > Right ->
    Score;
bag_of_tokens_score(Tokens, Power, Score, Left, Right) ->
    case Power >= lists:nth(Left + 1, Tokens) of
        true ->
            bag_of_tokens_score(Tokens, Power - lists:nth(Left + 1, Tokens), Score + 1, Left + 1, Right);
        false ->
            case Score > 0 andalso Left < Right of
                true ->
                    bag_of_tokens_score(Tokens, Power + lists:nth(Right + 1, Tokens), Score - 1, Left, Right - 1);
                false ->
                    Score
            end
    end.