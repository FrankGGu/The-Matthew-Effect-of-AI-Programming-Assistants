-module(solution).
-export([schedule_course/1]).

schedule_course(Courses) ->
    Sorted = lists:sort(fun([D1, E1], [D2, E2]) -> 
                            if E1 =:= E2 -> D1 =< D2;
                               true -> E1 =< E2
                            end
                         end, Courses),
    process(Sorted, 0, []).

process([], Time, Heap) ->
    length(Heap);
process([[D, E] | Rest], Time, Heap) ->
    if Time + D =< E ->
            NewHeap = insert(Heap, D),
            NewTime = Time + D,
            process(Rest, NewTime, NewHeap);
       Heap =/= [] ->
            Max = hd(Heap),
            if D < Max ->
                    NewHeap = insert(tl(Heap), D),
                    NewTime = Time - Max + D,
                    process(Rest, NewTime, NewHeap);
               true ->
                    process(Rest, Time, Heap)
            end;
       true ->
            process(Rest, Time, Heap)
    end.

insert([], Val) -> [Val];
insert([H | T], Val) when H > Val -> [H | insert(T, Val)];
insert(T, Val) -> [Val | T].