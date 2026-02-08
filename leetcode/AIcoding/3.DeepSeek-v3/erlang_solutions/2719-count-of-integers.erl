-module(solution).
-export([count/3]).

count(Num1, Num2, Min_sum, Max_sum) ->
    {D1, D2} = {length(Num1), length(Num2)},
    Num1Int = list_to_integer(Num1),
    Num2Int = list_to_integer(Num2),
    case D1 == D2 of
        true ->
            (count_less_equal(Num2, Min_sum, Max_sum) - count_less_equal(Num1, Min_sum, Max_sum) + 
             case digit_sum(Num1) >= Min_sum andalso digit_sum(Num1) =< Max_sum of
                 true -> 1;
                 false -> 0
             end) rem 1000000007;
        false ->
            Total = lists:sum([count_digits(D, Min_sum, Max_sum) || D <- lists:seq(D1 + 1, D2 - 1)]),
            (Total + count_less_equal(Num2, Min_sum, Max_sum) + count_greater_equal(Num1, Min_sum, Max_sum)) rem 1000000007
    end.

count_less_equal(Num, Min_sum, Max_sum) ->
    DP = init_dp(length(Num), Max_sum),
    count_dp(Num, Min_sum, Max_sum, DP, 0, 0, true).

count_greater_equal(Num, Min_sum, Max_sum) ->
    Total = count_digits(length(Num), Min_sum, Max_sum),
    Less = count_less_equal(Num, Min_sum, Max_sum),
    (Total - Less + 
     case digit_sum(Num) >= Min_sum andalso digit_sum(Num) =< Max_sum of
         true -> 1;
         false -> 0
     end) rem 1000000007.

count_dp([], Min_sum, Max_sum, _DP, Sum, _Tight, _IsFirst) ->
    case Sum >= Min_sum andalso Sum =< Max_sum of
        true -> 1;
        false -> 0
    end;
count_dp([D | Rest], Min_sum, Max_sum, DP, Sum, Tight, IsFirst) ->
    Digit = D - $0,
    Max = case Tight of true -> Digit; false -> 9 end,
    lists:sum([dp_lookup(Rest, Min_sum, Max_sum, DP, Sum + X, Tight andalso (X == Max), false) || X <- lists:seq(if IsFirst -> 1; true -> 0 end, Max)]).

dp_lookup(Num, Min_sum, Max_sum, DP, Sum, Tight, IsFirst) ->
    Key = {length(Num), Sum, Tight, IsFirst},
    case maps:get(Key, DP, undefined) of
        undefined ->
            Res = count_dp(Num, Min_sum, Max_sum, DP, Sum, Tight, IsFirst),
            DP1 = maps:put(Key, Res, DP),
            Res;
        Val -> Val
    end.

init_dp(Len, Max_sum) ->
    maps:new().

digit_sum(Num) ->
    lists:sum([C - $0 || C <- Num]).

count_digits(D, Min_sum, Max_sum) ->
    DP = init_dp(D, Max_sum),
    count_dp(lists:duplicate(D, $9), Min_sum, Max_sum, DP, 0, true, true).