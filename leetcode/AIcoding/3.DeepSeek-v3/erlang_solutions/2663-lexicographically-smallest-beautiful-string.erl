-module(solution).
-export([smallest_beautiful_string/2]).

smallest_beautiful_string(S, K) ->
    N = length(S),
    List = lists:map(fun(C) -> C - $a end, S),
    case backtrack(List, N - 1, K) of
        {ok, NewList} -> lists:map(fun(X) -> X + $a end, NewList);
        error -> ""
    end.

backtrack(List, Pos, K) ->
    if
        Pos < 0 -> error;
        true ->
            Current = lists:nth(Pos + 1, List),
            case find_next_valid(List, Pos, Current + 1, K) of
                {ok, NewVal} ->
                    NewList = set_nth(Pos + 1, NewVal, List),
                    fill_remaining(NewList, Pos + 1, K);
                error ->
                    backtrack(List, Pos - 1, K)
            end
    end.

find_next_valid(List, Pos, Start, K) ->
    if
        Start >= K -> error;
        true ->
            case (Pos < 1 orelse lists:nth(Pos, List) /= Start) andalso
                 (Pos < 2 orelse lists:nth(Pos - 1, List) /= Start) of
                true -> {ok, Start};
                false -> find_next_valid(List, Pos, Start + 1, K)
            end
    end.

fill_remaining(List, Pos, K) ->
    N = length(List),
    if
        Pos >= N -> {ok, List};
        true ->
            case find_next_valid(List, Pos, 0, K) of
                {ok, Val} ->
                    NewList = set_nth(Pos + 1, Val, List),
                    fill_remaining(NewList, Pos + 1, K);
                error -> error
            end
    end.

set_nth(1, Val, [_ | T]) -> [Val | T];
set_nth(N, Val, [H | T]) -> [H | set_nth(N - 1, Val, T)].