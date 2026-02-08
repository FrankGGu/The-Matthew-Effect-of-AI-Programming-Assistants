-module(minimum_changes_to_make_alternating_binary_string).
-export([minChanges/1]).

minChanges(S) ->
    Len = length(S),
    Even0 = countEven0(S, 0, 0),
    Even1 = countEven1(S, 0, 0),
    min(Even0, Even1).

countEven0([], _, Acc) -> Acc;
countEven0([H|T], Index, Acc) when Index rem 2 == 0 ->
    case H of
        $0 -> countEven0(T, Index + 1, Acc);
        _ -> countEven0(T, Index + 1, Acc + 1)
    end;
countEven0([H|T], Index, Acc) ->
    case H of
        $1 -> countEven0(T, Index + 1, Acc);
        _ -> countEven0(T, Index + 1, Acc + 1)
    end.

countEven1([], _, Acc) -> Acc;
countEven1([H|T], Index, Acc) when Index rem 2 == 0 ->
    case H of
        $1 -> countEven1(T, Index + 1, Acc);
        _ -> countEven1(T, Index + 1, Acc + 1)
    end;
countEven1([H|T], Index, Acc) ->
    case H of
        $0 -> countEven1(T, Index + 1, Acc);
        _ -> countEven1(T, Index + 1, Acc + 1)
    end.