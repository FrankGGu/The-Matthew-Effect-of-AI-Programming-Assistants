-module(beautiful_arrangement).
-export([count_arrangements/1]).

count_arrangements(N) ->
    count_arrangements(N, 1, []).

count_arrangements(_, _, _) when N < 1 ->
    0;

count_arrangements(N, Pos, Used) ->
    if
        Pos > N ->
            1;
        true ->
            lists:sum([
                case lists:member(I, Used) of
                    false ->
                        case (I rem Pos == 0) or (Pos rem I == 0) of
                            true ->
                                count_arrangements(N, Pos + 1, [I | Used]);
                            false ->
                                0
                        end;
                    true ->
                        0
                end || I <- lists:seq(1, N)
            ])
    end.