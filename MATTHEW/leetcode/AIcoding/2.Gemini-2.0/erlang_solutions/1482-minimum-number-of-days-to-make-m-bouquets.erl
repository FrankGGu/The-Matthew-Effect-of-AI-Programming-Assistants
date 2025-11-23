-module(min_bouquets).
-export([min_days/3]).

min_days(BloomDay, M, K) ->
  N = length(BloomDay),
  if M * K > N ->
    -1;
  true ->
    lists:sort(BloomDay)
    end.

min_days(BloomDay, M, K) ->
    N = length(BloomDay),
    if M * K > N then
        -1
    else
        L = lists:sort(BloomDay),
        binary_search(L, M, K)
    end.

binary_search(L, M, K) ->
    binary_search(L, M, K, 1, lists:last(L)).

binary_search(L, M, K, Low, High) ->
    if Low > High then
        Low
    else
        Mid = (Low + High) div 2,
        if possible(L, M, K, Mid) then
            binary_search(L, M, K, Low, Mid - 1)
        else
            binary_search(L, M, K, Mid + 1, High)
        end
    end.

possible(L, M, K, Day) ->
    possible(L, M, K, Day, 0, 0, 0).

possible([], _M, _K, _Day, Bouquets, _Adjacent, _Index) ->
    Bouquets;

possible([H | T], M, K, Day, Bouquets, Adjacent, _Index) ->
    if H =< Day then
        case Adjacent + 1 of
            K ->
                possible(T, M, K, Day, Bouquets + 1, 0, 0);
            _ ->
                possible(T, M, K, Day, Bouquets, Adjacent + 1, 0)
        end
    else
        possible(T, M, K, Day, Bouquets, 0, 0)
    end.

possible(L, M, K, Day) ->
    bouquets_possible(L, M, K, Day, 0, 0).

bouquets_possible([], _M, _K, _Day, Bouquets, _Adjacent) ->
    Bouquets >= _M;

bouquets_possible([H | T], M, K, Day, Bouquets, Adjacent) ->
    if H =< Day then
        case Adjacent + 1 of
            K ->
                bouquets_possible(T, M, K, Day, Bouquets + 1, 0);
            _ ->
                bouquets_possible(T, M, K, Day, Bouquets, Adjacent + 1)
        end
    else
        bouquets_possible(T, M, K, Day, Bouquets, 0)
    end.