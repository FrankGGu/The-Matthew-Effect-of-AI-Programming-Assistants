-module(solution).
-export([maxTaxiEarnings/2]).

maxTaxiEarnings(N, rides) ->
    Ride = lists:foldl(fun({start, end, tip}, Acc) ->
        Start = start,
        End = end,
        Tip = tip,
        Earnings = End - Start + Tip,
        case lists:keyfind(Start, 1, Acc) of
            false -> [{Start, Earnings} | Acc];
            {Start, MaxEarnings} ->
                NewMaxEarnings = max(MaxEarnings, Earnings),
                lists:keyreplace(Start, 1, Acc, {Start, NewMaxEarnings})
        end
    end, [], rides),
    MaxEarningsAcc = lists:foldl(fun({_, Earnings}, Acc) -> max(Acc, Earnings) end, 0, Ride),
    MaxEarningsAcc.