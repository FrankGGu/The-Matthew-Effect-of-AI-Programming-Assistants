-module(asteroid_collision).
-export([asteroid_collision/1]).

asteroid_collision(Asteroids) ->
  stack_collision(Asteroids, []).

stack_collision([], Stack) ->
  lists:reverse(Stack);
stack_collision([Asteroid | Rest], Stack) ->
  case Stack of
    [] ->
      stack_collision(Rest, [Asteroid]);
    [Top | _] ->
      if
        Asteroid > 0 ->
          stack_collision(Rest, [Asteroid | Stack]);
        Top > 0 ->
          if
            Top < abs(Asteroid) ->
              stack_collision([Asteroid | Rest], lists:delete(Top, Stack));
            Top == abs(Asteroid) ->
              stack_collision(Rest, lists:delete(Top, Stack));
            true ->
              stack_collision(Rest, Stack)
          end;
        true ->
          stack_collision(Rest, [Asteroid | Stack])
      end
  end.