-module(solution).
-export([shopping_offers/3]).

shopping_offers(Price, Special, Needs) ->
    solve(Price, Special, Needs).

solve(Price, Special, Needs) ->
    case all_zero(Needs) of
        true -> 0;
        false ->
            Min1 = lists:sum(lists:zipwith(fun(P, N) -> P * N end, Price, Needs)),
            Min2 = lists:foldl(fun(Offer, Acc) ->
                case can_apply(Offer, Needs) of
                    true ->
                        NewNeeds = apply_offer(Offer, Needs),
                        Cost = lists:nth(length(Offer), Offer) + solve(Price, Special, NewNeeds),
                        min(Acc, Cost);
                    false ->
                        Acc
                end
            end, Min1, Special),
            Min2
    end.

all_zero(List) ->
    lists:all(fun(X) -> X =:= 0 end, List).

can_apply(Offer, Needs) ->
    lists:all(fun({O, N}) -> O =< N end, lists:zip(lists:sublist(Offer, length(Needs)), Needs)).

apply_offer(Offer, Needs) ->
    lists:zipwith(fun(N, O) -> N - O end, Needs, lists:sublist(Offer, length(Needs))).