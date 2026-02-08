-module(solution).
-export([max_tasks/2]).

max_tasks(Task, Worker) ->
    lists:foldl(fun({W, T}, Acc) -> 
        case lists:member(W, Worker) of 
            true -> Acc + 1; 
            false -> Acc 
        end 
    end, 0, Task).