-module(closest_dessert_cost).
-export([closest_cost/3]).

closest_cost(Costs, Kids, Target) ->
    Lists = lists:map(fun(_) -> [Costs] end, lists:seq(1, Kids)),
    AllCombinations = generate_combinations(Lists),
    Candidates = lists:foldl(fun(Comb, Acc) ->
        Total = lists:sum(Comb),
        case abs(Total - Target) < abs(lists:last(Acc) - Target) of
            true -> [Total | Acc];
            false -> Acc
        end
    end, [infinity], AllCombinations),
    lists:min(Candidates).

generate_combinations([]) -> [[]];
generate_combinations([H|T]) ->
    lists:flatmap(fun(HVal) ->
        lists:map(fun(TVal) -> [HVal | TVal] end, generate_combinations(T))
    end, H).