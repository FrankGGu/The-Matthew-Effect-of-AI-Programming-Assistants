-module(solution).
-export([can_construct/1]).

can_construct(Blocks) ->
    can_construct(Blocks, 0, 0).

can_construct([], _, _) -> true;
can_construct([Block | Rest], X, Y) ->
    case Block of
        {X, Y} -> can_construct(Rest, X, Y);
        _ -> false
    end.