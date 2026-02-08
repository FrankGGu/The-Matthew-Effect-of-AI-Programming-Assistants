-module(solution).

-export([find_first_player/2]).

find_first_player(Players, K) ->
    find_first_player(Players, K, 0, 0, 0, 0).

find_first_player([], _, _, _, _, _) ->
    -1;
find_first_player([H | T], K, C, P, F, R) ->
    if
        H =:= P ->
            case C + 1 =:= K of
                true -> H;
                false -> find_first_player(T, K, C + 1, P, F, R)
            end;
        true ->
            find_first_player(T, K, 1, H, F + 1, R)
    end.