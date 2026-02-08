-module(max_length_of_pair_chain).
-export([find_longest_chain/1]).

find_longest_chain(Pairs) ->
    Sorted = lists:sort(fun({A, B}, {C, D}) -> A < C end, Pairs),
    dp(Sorted, []).

dp([], Acc) ->
    length(Acc);
dp([H | T], Acc) ->
    case Acc of
        [] ->
            dp(T, [H]);
        _ ->
            [Last | _] = Acc,
            case element(2, Last) < element(1, H) of
                true ->
                    dp(T, [H | Acc]);
                false ->
                    dp(T, Acc)
            end
    end.