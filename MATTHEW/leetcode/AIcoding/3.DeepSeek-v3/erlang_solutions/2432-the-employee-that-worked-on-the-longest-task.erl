-spec hardest_worker(_ :: integer(), [[integer()]]) -> integer().
hardest_worker(_, Logs) ->
    {MaxTime, Worker} = lists:foldl(
        fun([Id, EndTime], {PrevTime, PrevWorker}) ->
            Time = EndTime - PrevTime,
            if
                Time > MaxTime -> {Time, Id};
                Time == MaxTime andalso Id < PrevWorker -> {Time, Id};
                true -> {MaxTime, PrevWorker}
            end
        end,
        {0, hd(hd(Logs))},
        Logs
    ),
    Worker.