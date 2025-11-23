-module(my_calendar_iii).
-export([init/0, book/3]).

init() ->
    [].

book(Marks, StartTime, EndTime) ->
    NewMarks = Marks ++ [{StartTime, start}, {EndTime, end}],
    MaxOverlap = calculate_max_overlap(NewMarks),
    {NewMarks, MaxOverlap}.

calculate_max_overlap(Marks) ->
    MappedMarks = lists:map(fun({T, start}) -> {T, 1}; ({T, end}) -> {T, -1} end, Marks),

    SortedMarks = lists:sort(fun({T1, V1}, {T2, V2}) ->
                                     if T1 =/= T2 -> T1 < T2;
                                        true -> V1 > V2
                                     end
                             end, MappedMarks),

    lists:foldl(fun({_Time, Value}, {CurrentOverlap, MaxOverlap}) ->
                        NewCurrentOverlap = CurrentOverlap + Value,
                        NewMaxOverlap = max(MaxOverlap, NewCurrentOverlap),
                        {NewCurrentOverlap, NewMaxOverlap}
                end, {0, 0}, SortedMarks).