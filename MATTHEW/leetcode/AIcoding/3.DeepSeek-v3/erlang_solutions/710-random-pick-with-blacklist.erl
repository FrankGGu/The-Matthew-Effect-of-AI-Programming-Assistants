-module(solution).
-export([init/1, pick/0]).

-record(state, {
    n :: integer(),
    blacklist :: list(integer()),
    mapping :: map()
}).

-spec init_(N :: integer(), Blacklist :: [integer()]) -> any().
init(N, Blacklist) ->
    BlackSet = sets:from_list(Blacklist),
    M = N - length(Blacklist),
    Keys = [X || X <- Blacklist, X < M],
    Vals = [Y || Y <- lists:seq(M, N - 1), not sets:is_element(Y, BlackSet)],
    Mapping = maps:from_list(lists:zip(Keys, Vals)),
    {ok, #state{n = M, blacklist = Blacklist, mapping = Mapping}}.

-spec pick() -> integer().
pick() ->
    {ok, State} = get(state),
    R = rand:uniform(State#state.n) - 1,
    case maps:get(R, State#state.mapping, undefined) of
        undefined -> R;
        Val -> Val
    end.