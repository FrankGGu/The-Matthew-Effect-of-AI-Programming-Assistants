-module(filling_bookcase_shelves).
-export([min_height_shelves/2]).

min_height_shelves(Books, ShelfWidth) ->
    N = length(Books),
    memo(Books, ShelfWidth, N).

memo(Books, ShelfWidth, N) ->
    dp(Books, ShelfWidth, N, lists:duplicate(N+1, -1)).

dp(Books, ShelfWidth, N, Memo) ->
    case lists:nth(N, Memo) of
        -1 ->
            case N of
                0 ->
                    0;
                _ ->
                    Result = calculate_min_height(Books, ShelfWidth, N, Memo),
                    NewMemo = lists:replace(N, Result, Memo),
                    NewMemo !;
            end;
        Result ->
            Result
    end.

calculate_min_height(Books, ShelfWidth, N, Memo) ->
    MinHeight = lists:foldl(
        fun(I, Acc) ->
            CurrentWidth = calculate_width(Books, I, N);
            if CurrentWidth =< ShelfWidth then
                MaxHeight = calculate_max_height(Books, I, N),
                NewHeight = dp(Books, ShelfWidth, I - 1, Memo) + MaxHeight,
                min(Acc, NewHeight)
            else
                Acc
            end
        end,
        infinity,
        lists:seq(1, N)
    ),
    MinHeight.

calculate_width(Books, Start, End) ->
    lists:foldl(
        fun(I, Acc) ->
            {Width, _Height} = lists:nth(I, Books),
            Acc + Width
        end,
        0,
        lists:seq(Start, End)
    ).

calculate_max_height(Books, Start, End) ->
    lists:foldl(
        fun(I, Acc) ->
            {_Width, Height} = lists:nth(I, Books),
            max(Acc, Height)
        end,
        0,
        lists:seq(Start, End)
    ).

infinity() ->
    16#7fffffff.