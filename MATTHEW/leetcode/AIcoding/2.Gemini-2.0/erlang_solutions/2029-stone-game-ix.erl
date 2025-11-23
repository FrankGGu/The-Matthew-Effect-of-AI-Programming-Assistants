-module(stone_game_ix).
-export([stone_game_ix/1]).

stone_game_ix(Stones) ->
    Counts = lists:foldl(fun(Stone, Acc) ->
                                    case Stone rem 3 of
                                        0 -> {Acc#t{zero = Acc#t.zero + 1}};
                                        1 -> {Acc#t{one = Acc#t.one + 1}};
                                        2 -> {Acc#t{two = Acc#t.two + 1}}
                                    end
                                end, #t{zero = 0, one = 0, two = 0}, Stones),

    case Counts#t.zero rem 2 of
        0 -> Counts#t.one >= 1 andalso Counts#t.two >= 1;
        1 -> abs(Counts#t.one - Counts#t.two) > 2
    end.

-record(t, {zero, one, two}).