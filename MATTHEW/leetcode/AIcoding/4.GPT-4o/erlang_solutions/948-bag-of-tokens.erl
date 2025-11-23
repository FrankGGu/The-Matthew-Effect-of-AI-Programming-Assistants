-module(bag_of_tokens).
-export([bag_of_tokens/2]).

bag_of_tokens(Tokens, P) ->
    SortedTokens = lists:sort(Tokens),
    bag_of_tokens(SortedTokens, P, 0, 0).

bag_of_tokens([], _, MaxPoints, _) -> 
    MaxPoints;
bag_of_tokens(Tokens, P, MaxPoints, Points) ->
    case Tokens of
        [H | T] when Points < length(Tokens) ->
            NewPoints = Points + 1,
            NewP = P - H,
            if
                NewP < 0 -> 
                    MaxPoints;
                true -> 
                    bag_of_tokens(T, NewP, max(MaxPoints, NewPoints), NewPoints)
            end;
        _ -> 
            MaxPoints
    end.