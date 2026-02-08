-module(solution).
-export([minProcessingTime/2]).

minProcessingTime(ProcessorTime, Tasks) ->
    SortedProcessorTime = lists:sort(ProcessorTime),
    SortedTasksDesc = lists:reverse(lists:sort(Tasks)),

    TasksPerProcessor = 4, % Given constraint: each processor handles 4 tasks

    calculate_max_completion_time(SortedProcessorTime, SortedTasksDesc, TasksPerProcessor, 0, 0).

calculate_max_completion_time([], _SortedTasksDesc, _TasksPerProcessor, _TaskOffset, MaxTime) ->
    MaxTime;
calculate_max_completion_time([P | RestProcessors], SortedTasksDesc, TasksPerProcessor, TaskOffset, CurrentMaxTime) ->
    LargestTaskForProcessor = lists:nth(TaskOffset + 1, SortedTasksDesc),

    CompletionTime = P + LargestTaskForProcessor,

    NewMaxTime = max(CurrentMaxTime, CompletionTime),

    calculate_max_completion_time(RestProcessors, SortedTasksDesc, TasksPerProcessor, TaskOffset + TasksPerProcessor, NewMaxTime).