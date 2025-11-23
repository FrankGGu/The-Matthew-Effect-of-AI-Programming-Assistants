-module(solution).
-export([longest_task/2]).

longest_task(_N, Logs) ->
    {_MaxDuration, ResultEmployeeId, _PreviousTime} = lists:foldl(
        fun([EmployeeId, CurrentTime], {MaxDuration, ResultEmployeeIdAcc, PreviousTime}) ->
            CurrentDuration = CurrentTime - PreviousTime,
            if
                CurrentDuration > MaxDuration ->
                    {CurrentDuration, EmployeeId, CurrentTime};
                CurrentDuration == MaxDuration ->
                    {MaxDuration, min(ResultEmployeeIdAcc, EmployeeId), CurrentTime};
                true -> % CurrentDuration < MaxDuration
                    {MaxDuration, ResultEmployeeIdAcc, CurrentTime}
            end
        end,
        {-1, 100001, 0}, % Initial accumulator: {MaxDuration, ResultEmployeeId, PreviousTime}
        Logs
    ),
    ResultEmployeeId.