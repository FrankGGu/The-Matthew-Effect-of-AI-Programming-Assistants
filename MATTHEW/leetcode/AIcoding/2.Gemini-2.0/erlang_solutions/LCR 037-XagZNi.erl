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
        Top > 0 and Asteroid < 0 ->
          case compare(Top, Asteroid) of
            1 ->
              stack_collision(Rest, Stack);
            0 ->
              stack_collision(Rest, lists:sublist(Stack, 1, length(Stack) - 1));
            -1 ->
              stack_collision([Asteroid | Rest], lists:sublist(Stack, 1, length(Stack) - 1))
          end;
        true ->
          stack_collision(Rest, [Asteroid | Stack])
      end
  end.

compare(A, B) ->
  if
    A > abs(B) -> 1;
    A == abs(B) -> 0;
    true -> -1
  end.