-module(falling_squares).
-export([falling_squares/1]).

falling_squares(positions) ->
    falling_squares(positions, [], []).

falling_squares([], Acc, Result) ->
    lists:reverse(Result);
falling_squares([[[L, W] | _] | Rest], Acc, Result) ->
    Height = W,
    {NewAcc, MaxHeight} = update_height(L, W, Height, Acc),
    falling_squares(Rest, NewAcc, [MaxHeight || lists:last(Result, 0) < MaxHeight] ++ Result).

update_height(L, W, Height, []) ->
    {[[L, L + W, Height]], Height};
update_height(L, W, Height, Acc) ->
    End = L + W,
    {NewAcc, MaxHeight} = lists:foldl(
        fun([AL, AR, AH], {NA, MH}) ->
            case (L < AR) and (End > AL) of
                true ->
                    {NA, max(MH, AH)};
                false ->
                    {NA, MH}
            end
        end, {Acc, 0}, Acc),
    NewHeight = Height + MaxHeight,
    NewAcc2 = lists:foldl(
        fun([AL, AR, AH], NA) ->
            case (L < AR) and (End > AL) of
                true ->
                    NA;
                false ->
                    [ [AL, AR, AH] | NA]
            end
        end, [], Acc),
    {[[L, End, NewHeight] | NewAcc2], NewHeight}.