-module(solution).
-export([num_ways/1]).

num_ways(Arr) ->
    N = length(Arr),
    Sum = lists:sum(Arr),
    LeftSum = 0,
    RightSum = Sum,
    Count = 0,
    num_ways(Arr, 0, N - 1, LeftSum, RightSum, Count).

num_ways(_, _, _, _, _, Count) when N < 3 -> Count;
num_ways(Arr, I, J, LeftSum, RightSum, Count) ->
    if
        I >= J - 1 -> Count;
        true ->
            NewLeftSum = LeftSum + element(I + 1, Arr),
            NewRightSum = RightSum - element(J, Arr),
            if
                NewLeftSum >= NewRightSum -> num_ways(Arr, I + 1, J, NewLeftSum, RightSum, Count);
                true -> num_ways(Arr, I, J - 1, LeftSum, NewRightSum, Count + 1)
            end
    end.