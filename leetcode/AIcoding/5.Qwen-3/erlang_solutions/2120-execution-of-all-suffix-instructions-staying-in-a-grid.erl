-module(solution).
-export([execute_instructions/2]).

execute_instructions(Grid, Instructions) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {Pos, _} = lists:foldl(fun(I, {R, C}) ->
        case I of
            $U -> {R - 1, C};
            $D -> {R + 1, C};
            $L -> {R, C - 1};
            $R -> {R, C + 1}
        end
    end, {0, 0}, Instructions),
    Results = lists:seq(0, length(Instructions) - 1),
    lists:map(fun(I) -> check_valid(Grid, Pos, I) end, Results).

check_valid(Grid, {R, C}, Index) ->
    [H | T] = lists:reverse(lists:sublist(lists:reverse(Instructions), Index + 1)),
    {NewR, NewC} = lists:foldl(fun(I, {Rr, Cc}) ->
        case I of
            $U -> {Rr - 1, Cc};
            $D -> {Rr + 1, Cc};
            $L -> {Rr, Cc - 1};
            $R -> {Rr, Cc + 1}
        end
    end, {R, C}, H),
    if
        NewR >= 0, NewR < length(Grid), NewC >= 0, NewC < length(hd(Grid)) -> 1;
        true -> 0
    end.