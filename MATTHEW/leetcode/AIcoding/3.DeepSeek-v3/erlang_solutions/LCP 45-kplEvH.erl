-module(solution).
-export([bicycle_yard/1]).

bicycle_yard(Position) ->
    {X, Y} = Position,
    #{
        {X, Y} => #{1 => true}
    }.

-spec bicycle_yard(Position :: {integer(), integer()}) -> #{ {integer(), integer()} => #{ integer() => boolean() } }.
bicycle_yard(Position) ->
    {X, Y} = Position,
    #{
        {X, Y} => #{1 => true}
    }.