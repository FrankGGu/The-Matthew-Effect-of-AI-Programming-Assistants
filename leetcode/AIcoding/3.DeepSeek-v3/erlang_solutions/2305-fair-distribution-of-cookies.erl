-spec distribute_cookies(Cookies :: [integer()], K :: integer()) -> integer().
distribute_cookies(Cookies, K) ->
    N = length(Cookies),
    Min = lists:max(Cookies),
    Max = lists:sum(Cookies),
    binary_search(Cookies, K, Min, Max, Min).

binary_search(Cookies, K, Low, High, Result) ->
    if
        Low > High -> Result;
        true ->
            Mid = (Low + High) div 2,
            case can_distribute(Cookies, K, Mid) of
                true ->
                    binary_search(Cookies, K, Low, Mid - 1, Mid);
                false ->
                    binary_search(Cookies, K, Mid + 1, High, Result)
            end
    end.

can_distribute(Cookies, K, Limit) ->
    can_distribute(Cookies, K, Limit, 0, 1).

can_distribute([], _, _, Sum, _) ->
    Sum =:= 0;
can_distribute(_, K, _, _, Count) when Count > K ->
    false;
can_distribute([C | Rest], K, Limit, Sum, Count) ->
    NewSum = Sum + C,
    if
        NewSum > Limit ->
            can_distribute(Rest, K, Limit, C, Count + 1);
        true ->
            can_distribute(Rest, K, Limit, NewSum, Count)
    end.