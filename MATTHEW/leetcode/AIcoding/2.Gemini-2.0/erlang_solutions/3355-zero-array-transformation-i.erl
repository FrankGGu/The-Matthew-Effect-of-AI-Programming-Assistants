-module(zero_array_transformation_i).
-export([can_transform/1]).

can_transform([0]).

can_transform(A) ->
    can_transform(A, 0).

can_transform([], _Count) ->
    true;
can_transform([0 | T], Count) ->
    can_transform(T, Count);
can_transform([_ | T], 0) ->
    can_transform(T, 1);
can_transform([_ | _], Count) when Count > 0 ->
    false.