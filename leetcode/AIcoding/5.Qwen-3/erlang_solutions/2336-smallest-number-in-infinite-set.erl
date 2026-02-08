-module(solution).
-export([init/0, addBack/2, popSmallest/1]).

init() ->
    {ok, lists:seq(1, 100)}.

addBack(State, Num) ->
    case lists:member(Num, State) of
        true -> State;
        false -> lists:usort([Num | State])
    end.

popSmallest(State) ->
    [Smallest | Rest] = State,
    {Smallest, Rest}.