-module(solution).
-export([min_platforms/2]).

min_platforms(Arr, Dep) ->
    SortedArr = lists:sort(Arr),
    SortedDep = lists:sort(Dep),
    min_platforms_helper(SortedArr, SortedDep, length(SortedArr), length(SortedDep), 0, 0).

min_platforms_helper([], [], _, _, _, Max) ->
    Max;
min_platforms_helper([H | T], Dep, ArrLen, DepLen, Current, Max) when Current > 0 ->
    case Dep of
        [] -> min_platforms_helper(T, Dep, ArrLen, DepLen, Current + 1, max(Current, Max));
        [D | Rest] when D < H -> min_platforms_helper([H | T], Rest, ArrLen, DepLen, Current - 1, Max);
        _ -> min_platforms_helper(T, Dep, ArrLen, DepLen, Current + 1, max(Current, Max))
    end;
min_platforms_helper([H | T], [D | Rest], ArrLen, DepLen, Current, Max) ->
    case D < H of
        true -> min_platforms_helper([H | T], Rest, ArrLen, DepLen, Current - 1, Max);
        false -> min_platforms_helper(T, [D | Rest], ArrLen, DepLen, Current + 1, max(Current, Max))
    end.