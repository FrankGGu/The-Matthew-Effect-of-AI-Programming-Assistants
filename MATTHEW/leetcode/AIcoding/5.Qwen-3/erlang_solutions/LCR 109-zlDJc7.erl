-module(open_lock).
-export([open_lock/1]).

open_lock(Deadends) ->
    open_lock(Deadends, 0, 0, 0, 0, dict:from_list(Deadends), 0).

open_lock(Deadends, A, B, C, D, Dead, Steps) ->
    State = {A, B, C, D},
    case dict:is_key(State, Dead) of
        true -> -1;
        false ->
            case State == {0, 0, 0, 0} of
                true -> Steps;
                false ->
                    NewDead = dict:store(State, true, Dead),
                    Queue = queue:from_list([{A, B, C, D, Steps}]),
                    bfs(Queue, NewDead)
            end
    end.

bfs(Queue, Dead) ->
    case queue:is_empty(Queue) of
        true -> -1;
        false ->
            {value, {A, B, C, D, Steps}, Rest} = queue:out(Queue),
            NextSteps = Steps + 1,
            Neighbors = generate_neighbors(A, B, C, D),
            lists:foldl(fun(Neighbor, Acc) ->
                            case dict:is_key(Neighbor, Dead) of
                                true -> Acc;
                                false ->
                                    dict:store(Neighbor, true, Dead),
                                    if Neighbor == {0, 0, 0, 0} -> NextSteps;
                                       true -> bfs(queue:in({Neighbor, NextSteps}, Acc))
                                    end
                        end, Rest, Neighbors)
    end.

generate_neighbors(A, B, C, D) ->
    [ {A+1 rem 10, B, C, D},
      {A-1 rem 10, B, C, D},
      {A, B+1 rem 10, C, D},
      {A, B-1 rem 10, C, D},
      {A, B, C+1 rem 10, D},
      {A, B, C-1 rem 10, D},
      {A, B, C, D+1 rem 10},
      {A, B, C, D-1 rem 10} ].