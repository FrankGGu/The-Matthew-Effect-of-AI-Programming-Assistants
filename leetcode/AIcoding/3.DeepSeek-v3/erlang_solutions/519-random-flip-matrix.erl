-module(solution).
-export([init/2, flip/1, reset/1]).

-record(state, {rows, cols, total, used, rng}).

init(Rows, Cols) ->
    RNG = rand:seed(exsplus),
    State = #state{
        rows = Rows,
        cols = Cols,
        total = Rows * Cols,
        used = #{},
        rng = RNG
    },
    {ok, State}.

flip(State) ->
    #state{total = Total, used = Used, rng = RNG} = State,
    {Rand, NewRNG} = rand:uniform_s(RNG, Total),
    X = case maps:get(Rand, Used, undefined) of
        undefined -> Rand;
        Val -> Val
    end,
    NewUsed = maps:put(Rand, maps:get(Total, Used, Total), Used),
    NewState = State#state{
        total = Total - 1,
        used = NewUsed,
        rng = NewRNG
    },
    Row = (X - 1) div State#state.cols,
    Col = (X - 1) rem State#state.cols,
    {[Row, Col], NewState}.

reset(State) ->
    NewState = State#state{
        total = State#state.rows * State#state.cols,
        used = #{},
        rng = State#state.rng
    },
    {ok, NewState}.