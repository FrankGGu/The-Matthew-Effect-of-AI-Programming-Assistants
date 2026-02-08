-module(solution).
-export([pyramid_transition/2]).

pyramid_transition(Top, Bottom) ->
    Transition = lists:map(fun({X, Y}) -> X ++ Y end, lists:zip(Bottom, lists:tl(Bottom))),
    can_form_pyramid(Top, Transition).

can_form_pyramid([], _) -> true;
can_form_pyramid([H | T], Transition) ->
    case lists:any(fun(X) -> lists:member(H, X) end, Transition) of
        true -> can_form_pyramid(T, Transition);
        false -> false
    end.