-module(solution).
-export([has_valid_path/1]).

has_valid_path(Grid) ->
    case Grid of
        [] -> false;
        _ ->
            Rows = length(Grid),
            Cols = length(hd(Grid)),
            case dfs(0, 0, 0, Rows, Cols, Grid, #{}) of
                true -> true;
                _ -> false
            end
    end.

dfs(R, C, Balance, Rows, Cols, Grid, Memo) ->
    case {R, C} of
        {Rows - 1, Cols - 1} ->
            NewBalance = update_balance(Balance, lists:nth(C + 1, lists:nth(R + 1, Grid))),
            NewBalance == 0;
        _ ->
            Key = {R, C, Balance},
            case maps:get(Key, Memo, undefined) of
                undefined ->
                    NewBalance = update_balance(Balance, lists:nth(C + 1, lists:nth(R + 1, Grid))),
                    if
                        NewBalance < 0 ->
                            maps:put(Key, false, Memo),
                            false;
                        true ->
                            Right = if
                                C + 1 < Cols -> dfs(R, C + 1, NewBalance, Rows, Cols, Grid, Memo);
                                true -> false
                            end,
                            Down = if
                                R + 1 < Rows -> dfs(R + 1, C, NewBalance, Rows, Cols, Grid, Memo);
                                true -> false
                            end,
                            Result = Right or Down,
                            maps:put(Key, Result, Memo),
                            Result
                    end;
                Result ->
                    Result
            end
    end.

update_balance(Balance, Char) ->
    case Char of
        $( -> Balance + 1;
        $) -> Balance - 1
    end.