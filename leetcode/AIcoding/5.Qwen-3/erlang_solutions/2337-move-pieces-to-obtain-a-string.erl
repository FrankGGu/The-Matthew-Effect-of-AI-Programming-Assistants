-module(move_pieces_to_obtain_a_string).
-export([canBeEqual/2]).

canBeEqual(Start, Target) ->
    canBeEqual(Start, Target, []).

canBeEqual([], [], _) -> true;
canBeEqual([], _, _) -> false;
canBeEqual(_, [], _) -> false;
canBeEqual([H|T], [H|T2], Acc) ->
    canBeEqual(T, T2, Acc);
canBeEqual([H|T], [T1|T2], Acc) ->
    case H of
        $L ->
            case lists:member($R, Acc) of
                true -> canBeEqual(T, T2, lists:delete($R, Acc) ++ [$L]);
                false -> false
            end;
        $R ->
            canBeEqual(T, T2, Acc ++ [$R]);
        _ -> false
    end.