-module(solution).
-export([construct_valid_sequence/1]).

construct_valid_sequence(N) ->
    construct_valid_sequence(N, 1, []).

construct_valid_sequence(N, Start, Acc) ->
    case find_next(N, Start, Acc) of
        false -> 
            case Acc of
                [] -> [];
                _ -> 
                    [H | T] = lists:reverse(Acc),
                    construct_valid_sequence(N, H + 1, T)
            end;
        Next ->
            construct_valid_sequence(N, 1, [Next | Acc])
    end.

find_next(N, Start, Acc) ->
    find_next(N, Start, Acc, N).

find_next(_, _, _, 0) -> false;
find_next(N, Start, Acc, I) ->
    if
        I < 1 -> false;
        true ->
            case is_valid(N, I, Acc) of
                true -> I;
                false -> find_next(N, Start, Acc, I - 1)
            end
    end.

is_valid(N, X, Acc) ->
    case Acc of
        [] -> true;
        _ ->
            Last = hd(Acc),
            (X + Last) == N + 1
    end.