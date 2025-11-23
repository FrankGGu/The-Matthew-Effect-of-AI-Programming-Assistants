-module(solution).
-export([minimum_beautiful_substrings/1]).

minimum_beautiful_substrings(S) ->
    N = length(S),
    DP = array:new([{size, N + 1}, {default, infinity}]),
    DP1 = array:set(0, 0, DP),
    {Ans, _} = lists:foldl(fun(I, {DPAcc, _}) ->
        lists:foldl(fun(J, {Min, DPIn}) ->
            case J =< I andalso is_valid(string:sub_string(S, J + 1, I + 1)) of
                true ->
                    case array:get(J, DPIn) + 1 < Min of
                        true -> {array:get(J, DPIn) + 1, DPIn};
                        false -> {Min, DPIn}
                    end;
                false ->
                    {Min, DPIn}
            end
        end, {infinity, DPAcc}, lists:seq(0, I - 1)),
        NewDP = array:set(I + 1, Ans, DPAcc),
        {NewDP, Ans}
    end, {DP1, 0}, lists:seq(0, N - 1)),
    case Ans == infinity of
        true -> -1;
        false -> Ans
    end.

is_valid(Sub) ->
    case Sub of
        [] -> false;
        [$0 | _] -> false;
        _ ->
            Len = length(Sub),
            Num = lists:foldl(fun(C, Acc) -> Acc * 2 + (C - $0) end, 0, Sub),
            is_power_of_five(Num)
    end.

is_power_of_five(N) when N =< 0 -> false;
is_power_of_five(1) -> true;
is_power_of_five(N) when N rem 5 =/= 0 -> false;
is_power_of_five(N) -> is_power_of_five(N div 5).