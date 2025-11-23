-module(solution).
-export([smallestNumber/1]).

smallestNumber(0) -> 0;
smallestNumber(Num) when Num > 0 ->
    Digits = integer_to_list(Num),
    SortedDigits = lists:sort(Digits),
    {Zeros, NonZeros} = lists:partition(fun(D) -> D == $0 end, SortedDigits),
    FirstNonZero = hd(NonZeros),
    RemainingNonZeros = tl(NonZeros),
    ResultList = [FirstNonZero | Zeros ++ RemainingNonZeros],
    list_to_integer(ResultList);
smallestNumber(Num) when Num < 0 ->
    AbsNum = abs(Num),
    Digits = integer_to_list(AbsNum),
    SortedDigits = lists:sort(Digits),
    SortedDigitsDesc = lists:reverse(SortedDigits),
    list_to_integer(SortedDigitsDesc) * -1.