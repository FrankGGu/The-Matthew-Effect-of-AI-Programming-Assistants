-module(smallest_sequence).
-export([smallest_sequence/1]).

smallest_sequence(N) ->
    case N =:= 1 of
        true -> [1];
        false ->
            lists:reverse(smallest_sequence_helper(N, [], lists:seq(1, N)))
    end.

smallest_sequence_helper(N, Acc, Available) ->
    find_smallest(N, Acc, Available).

find_smallest(0, Acc, _) ->
    Acc;
find_smallest(N, Acc, Available) ->
    Val = find_smallest_val(N, Acc, Available),
    case Val of
        no_val ->
            [];
        _ ->
            NewAcc = [Val | Acc],
            NewAvailable = lists:delete(Val, Available),
            case N =:= 1 of
                true ->
                    find_smallest(N - 1, NewAcc, NewAvailable);
                false ->
                    NewAcc2 = [N | NewAcc],
                    NewAvailable2 = lists:delete(N, NewAvailable),
                    find_smallest(N - 1, NewAcc2, NewAvailable2)
            end
    end.

find_smallest_val(N, Acc, Available) ->
    Possible = lists:filter(fun(X) -> can_place(X, N, Acc) end, Available),
    case Possible of
        [] ->
            no_val;
        _ ->
            lists:min(Possible)
    end.

can_place(Val, N, Acc) ->
    case N =:= 1 of
        true ->
            true;
        false ->
            case lists:member(N, Acc) of
                true ->
                    false;
                false ->
                    case lists:member(Val, Acc) of
                        true ->
                            false;
                        false ->
                            true
                    end
            end
    end.