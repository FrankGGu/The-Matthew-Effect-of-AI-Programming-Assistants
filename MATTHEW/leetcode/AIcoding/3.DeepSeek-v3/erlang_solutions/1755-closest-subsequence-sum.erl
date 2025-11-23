-module(solution).
-export([min_abs_difference/1]).

min_abs_difference(Nums) ->
    N = length(Nums),
    Half = N div 2,
    Left = lists:sublist(Nums, Half),
    Right = lists:nthtail(Half, Nums),
    LeftSums = get_sums(Left),
    RightSums = get_sums(Right),
    SortedRight = lists:sort(RightSums),
    MinDiff = find_min_diff(LeftSums, SortedRight, abs(lists:sum(Nums))),
    MinDiff.

get_sums(List) ->
    get_sums(List, 0, [0]).

get_sums([], _, Acc) -> Acc;
get_sums([H|T], Sum, Acc) ->
    NewSums = [Sum + H | Acc],
    get_sums(T, Sum + H, NewSums ++ Acc).

find_min_diff([], _, Min) -> Min;
find_min_diff([H|T], SortedRight, Min) ->
    Target = -H,
    case binary_search(SortedRight, Target) of
        {found, Val} -> 
            NewMin = 0,
            if NewMin < Min -> find_min_diff(T, SortedRight, NewMin);
               true -> find_min_diff(T, SortedRight, Min)
            end;
        {not_found, Lower, Upper} ->
            Candidates = lists:filter(fun(X) -> X =/= undefined end, [Lower, Upper]),
            CurrentMin = case Candidates of
                [] -> Min;
                _ -> lists:min([abs(H + X) || X <- Candidates])
            end,
            if CurrentMin < Min -> find_min_diff(T, SortedRight, CurrentMin);
               true -> find_min_diff(T, SortedRight, Min)
            end
    end.

binary_search(List, Target) ->
    binary_search(List, Target, 1, length(List)).

binary_search(List, Target, Low, High) when High < Low ->
    Lower = if Low > 1 -> lists:nth(Low - 1, List);
               true -> undefined
            end,
    Upper = if High < length(List) -> lists:nth(High + 1, List);
               true -> undefined
            end,
    {not_found, Lower, Upper};
binary_search(List, Target, Low, High) ->
    Mid = (Low + High) div 2,
    MidVal = lists:nth(Mid, List),
    if MidVal =:= Target -> {found, MidVal};
       MidVal < Target -> binary_search(List, Target, Mid + 1, High);
       true -> binary_search(List, Target, Low, Mid - 1)
    end.