-module(task_scheduler_ii).
-export([task_scheduler_ii/2]).

task_scheduler_ii(Tasks, Space) ->
    task_scheduler_ii(Tasks, Space, 0, {}).

task_scheduler_ii([], _, Acc, _) ->
    Acc;
task_scheduler_ii([Task | Rest], Space, Acc, Cooldown) ->
    case maps:is_key(Task, Cooldown) of
        true ->
            LastTime = maps:get(Task, Cooldown),
            NextAvailable = LastTime + Space + 1,
            case NextAvailable > Acc + 1 of
                true ->
                    NewAcc = NextAvailable - 1,
                    NewCooldown = maps:put(Task, NewAcc + 1, Cooldown),
                    task_scheduler_ii(Rest, Space, NewAcc + 1, NewCooldown);
                false ->
                    NewCooldown = maps:put(Task, Acc + 1, Cooldown),
                    task_scheduler_ii(Rest, Space, Acc + 1, NewCooldown)
            end;
        false ->
            NewCooldown = maps:put(Task, Acc + 1, Cooldown),
            task_scheduler_ii(Rest, Space, Acc + 1, NewCooldown)
    end.