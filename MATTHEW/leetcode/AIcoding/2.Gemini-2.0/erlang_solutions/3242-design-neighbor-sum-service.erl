-module(neighbor_sum).
-export([start/2, get_sum/1, update/3]).

start(Rows, Cols) ->
    {ok, Pid} = spawn_link(?MODULE, init, [Rows, Cols]),
    Pid.

init(Rows, Cols) ->
    State = #{
        grid => lists:duplicate(Rows, lists:duplicate(Cols, 0)),
        rows => Rows,
        cols => Cols
    },
    loop(State).

get_sum(Pid) ->
    Pid ! {get_sum, self()},
    receive
        {Pid, Sum} ->
            Sum
    end.

update(Pid, Row, Col, Value) ->
    Pid ! {update, Row, Col, Value},
    ok.

loop(State) ->
    receive
        {get_sum, Caller} ->
            Grid = maps:get(grid, State),
            Rows = maps:get(rows, State),
            Cols = maps:get(cols, State),
            Sum = lists:foldl(fun(Row, Acc) ->
                lists:foldl(fun(Val, Acc2) -> Acc2 + Val end, Acc, Row)
            end, 0, Grid),
            Caller ! {self(), Sum},
            loop(State);
        {update, Row, Col, Value} ->
            Grid = maps:get(grid, State),
            NewGrid = lists:update(Row, lists:update(Col, Value, lists:nth(Row, Grid)), Grid),
            NewState = State#{grid => NewGrid},
            loop(NewState)
    end.