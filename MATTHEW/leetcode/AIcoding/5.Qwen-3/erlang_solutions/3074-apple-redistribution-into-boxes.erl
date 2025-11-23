-module(solution).
-export([can_divide/1]).

can_divide(Apples) ->
    can_divide(Apples, 0).

can_divide([], _Count) ->
    true;
can_divide([A | Rest], Count) ->
    case Count of
        0 ->
            can_divide(Rest, A);
        _ ->
            if
                A == Count ->
                    can_divide(Rest, 0);
                true ->
                    false
            end
    end.