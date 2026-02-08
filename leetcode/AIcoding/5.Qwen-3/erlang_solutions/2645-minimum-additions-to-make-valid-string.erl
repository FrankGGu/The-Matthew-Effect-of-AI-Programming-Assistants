-module(minimum_additions_to_make_valid_string).
-export([min_additions/1]).

min_additions(S) ->
    min_additions(S, 0, 0).

min_additions([], Open, _) ->
    Open;
min_additions([H | T], Open, Close) ->
    case H of
        $'(' ->
            min_additions(T, Open + 1, Close);
        $')' ->
            if
                Close < Open ->
                    min_additions(T, Open, Close + 1);
                true ->
                    min_additions(T, Open, Close)
            end;
        _ ->
            min_additions(T, Open, Close)
    end.