-module(solution).
-export([numOfSubarrays/1]).

numOfSubarrays(Numbers) ->
    numOfOddSubarrays(Numbers, 0, 0, 0).

numOfOddSubarrays([], _, Count, _) -> 
    Count;
numOfOddSubarrays([H | T], EvenCount, Count, OddCount) ->
    NewCount = if
        (H rem 2) =:= 1 -> 
            OddCount + 1
        ; 
            OddCount
    end,
    NewEvenCount = EvenCount + (if (H rem 2) =:= 0 -> 1; true -> 0 end),
    NewCountAcc = Count + NewEvenCount,
    numOfOddSubarrays(T, NewEvenCount, NewCountAcc, NewCount).