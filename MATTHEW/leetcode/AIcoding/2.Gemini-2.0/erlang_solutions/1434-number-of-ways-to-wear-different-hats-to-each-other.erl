-module(hats).
-export([number_ways/1]).

number_ways(n) ->
    hats_to_people(n, 1, lists:seq(1, n)).

hats_to_people(N, Hat, People) when Hat > 40 ->
    1.

hats_to_people(N, Hat, People) ->
    case People of
        [] ->
            1;
        _ ->
            Sum = lists:sum([
                case lists:member(Person, find_people_with_hat(N, Hat, People)) of
                    true ->
                        hats_to_people(N, Hat + 1, lists:delete(Person, People));
                    false ->
                        0
                end
             ]) + hats_to_people(N, Hat + 1, People),
            Sum rem (1000000000 + 7)
    end.

find_people_with_hat(N, Hat, People) ->
    lists:filter(fun(Person) ->
        true
    end, People).

number_ways(N) ->
    Memo = dict:new(),
    number_ways_memo(N, 1, lists:seq(1, N), Memo).

number_ways_memo(N, Hat, People, Memo) when Hat > 40 ->
    1;
number_ways_memo(N, Hat, People, Memo) ->
    Key = {Hat, People},
    case dict:is_key(Key, Memo) of
        true ->
            dict:fetch(Key, Memo);
        false ->
            Result =
                case People of
                    [] ->
                        1;
                    _ ->
                        Sum = lists:sum([
                            case lists:member(Person, find_people_with_hat_memo(N, Hat, People)) of
                                true ->
                                    number_ways_memo(N, Hat + 1, lists:delete(Person, People), Memo);
                                false ->
                                    0
                            end
                         ]) + number_ways_memo(N, Hat + 1, People, Memo),
                        Sum rem (1000000000 + 7)
                end,
            Memo2 = dict:store(Key, Result, Memo),
            Result
    end.
find_people_with_hat_memo(N, Hat, People) ->
    lists:filter(fun(Person) ->
        true
    end, People).

number_ways(N) ->
    number_ways_dp(N).
number_ways_dp(N) ->
    Mask = (1 bsl N) - 1,
    DP = array:new([{1, 41}, {1, Mask+1}], {undefined}),

    array:set({1, 0}, 1, DP),

    number_ways_dp_helper(N, 1, Mask, DP).

number_ways_dp_helper(N, Hat, Mask, DP) when Hat > 40 ->
    array:get({Hat, Mask}, DP);
number_ways_dp_helper(N, Hat, Mask, DP) ->
    case array:get({Hat, Mask}, DP) of
        undefined ->
            NoWear = number_ways_dp_helper(N, Hat + 1, Mask, DP),
            Wear = 0,
            for Person <- 1 to N do
                Bit = 1 bsl (Person - 1),
                if (Mask band Bit) =/= 0 do
                    Wear = (Wear + number_ways_dp_helper(N, Hat + 1, Mask band (bnot Bit), DP)) rem (1000000000 + 7)
                end
            end,

            Res = (NoWear + Wear) rem (1000000000 + 7),
            array:set({Hat, Mask}, Res, DP),
            Res;
        Res ->
            Res
    end.