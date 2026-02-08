-module(target_array).
-export([create_target_array/1]).

create_target_array(Insert) ->
    create_target_array(Insert, []).

create_target_array([], Result) ->
    lists:reverse(Result);
create_target_array([I | Rest], Result) ->
    [I | Result] = lists:split(I, Result),
    create_target_array(Rest, [I | Result]).