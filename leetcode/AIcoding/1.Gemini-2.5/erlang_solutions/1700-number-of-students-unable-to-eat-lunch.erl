-module(solution).
-export([countStudents/2]).

countStudents(Students, Sandwiches) ->
    {Count0, Count1} = count_student_preferences(Students),
    process_sandwiches(Sandwiches, Count0, Count1).

count_student_preferences(Students) ->
    lists:foldl(fun(S, {C0, C1}) ->
                        if S == 0 -> {C0 + 1, C1};
                           true -> {C0, C1 + 1}
                        end
                end, {0, 0}, Students).

process_sandwiches([], Count0, Count1) ->
    Count0 + Count1;
process_sandwiches([Sandwich | RestSandwiches], Count0, Count1) ->
    if Sandwich == 0 ->
           if Count0 > 0 ->
                  process_sandwiches(RestSandwiches, Count0 - 1, Count1);
              true ->
                  Count0 + Count1
           end;
       true ->
           if Count1 > 0 ->
                  process_sandwiches(RestSandwiches, Count0, Count1 - 1);
              true ->
                  Count0 + Count1
           end
    end.