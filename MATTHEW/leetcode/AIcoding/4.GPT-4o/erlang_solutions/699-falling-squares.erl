-module(solution).
-export([falling_squares/1]).

falling_squares(Squares) ->
    MaxHeight = 0,
    FallingHeights = foldl(fun({L, H}, Acc) -> 
        {NewHeight, NewAcc} = place_square(L, H, Acc),
        {max(NewHeight, MaxHeight), NewAcc} 
    end, {0, []}, Squares),
    {MaxHeight, lists:reverse(fst(FallingHeights))}.

place_square(L, H, Acc) ->
    {NewHeight, NewAcc} = lists:foldl(fun(X, {MaxH, Hs}) ->
        case X of 
            {Start, Height} when Start < L + 1, Start + Height > L -> 
                {max(MaxH, Height + H), Hs}
            _ -> 
                {MaxH, Hs}
        end
    end, {0, Acc}, Acc),
    {NewHeight, [{L, NewHeight} | Acc]}.

fst({X, _}) -> X.