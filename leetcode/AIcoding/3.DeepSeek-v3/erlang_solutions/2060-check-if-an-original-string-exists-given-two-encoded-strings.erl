-module(solution).
-export([possibly_equals/2]).

possibly_equals(S1, S2) ->
    DP = #{{0, 0} => true},
    possibly_equals(S1, S2, DP).

possibly_equals(S1, S2, DP) ->
    case maps:size(DP) of
        0 -> false;
        _ ->
            NewDP = maps:new(),
            {Updated, Found} = maps:fold(
                fun({D1, D2}, _, {Acc, FoundAcc}) ->
                    case {S1, S2} of
                        {[], []} when D1 == 0, D2 == 0 -> {Acc, true};
                        _ ->
                            case process(S1, S2, D1, D2, Acc) of
                                {NewAcc, true} -> {NewAcc, true};
                                {NewAcc, false} -> {NewAcc, FoundAcc}
                            end
                    end
                end,
                {NewDP, false},
                DP
            ),
            case Found of
                true -> true;
                false -> possibly_equals(S1, S2, Updated)
            end
    end.

process(S1, S2, D1, D2, Acc) ->
    case {S1, S2} of
        {[C1 | Rest1], [C2 | Rest2]} when C1 >= $a, C1 =< $z, C2 >= $a, C2 =< $z ->
            if
                C1 == C2, D1 == 0, D2 == 0 ->
                    Key = {0, 0},
                    {maps:put(Key, true, Acc), false};
                true ->
                    {Acc, false}
            end;
        {[C1 | Rest1], [C2 | Rest2]} when C1 >= $a, C1 =< $z ->
            case D2 > 0 of
                true ->
                    Key = {D1, D2 - 1},
                    {maps:put(Key, true, Acc), false};
                false ->
                    case get_numbers(Rest2) of
                        {Ns, NewRest2} ->
                            process_numbers(Ns, fun(N) ->
                                Key = {D1, N - 1},
                                maps:put(Key, true, Acc)
                            end, {Acc, false}, NewRest2, C1, D1)
                    end
            end;
        {[C1 | Rest1], [C2 | Rest2]} when C2 >= $a, C2 =< $z ->
            case D1 > 0 of
                true ->
                    Key = {D1 - 1, D2},
                    {maps:put(Key, true, Acc), false};
                false ->
                    case get_numbers(Rest1) of
                        {Ns, NewRest1} ->
                            process_numbers(Ns, fun(N) ->
                                Key = {N - 1, D2},
                                maps:put(Key, true, Acc)
                            end, {Acc, false}, NewRest1, C2, D2)
                    end
            end;
        {[C1 | Rest1], [C2 | Rest2]} when C1 >= $0, C1 =< $9, C2 >= $0, C2 =< $9 ->
            case get_numbers(Rest1) of
                {Ns1, NewRest1} ->
                    case get_numbers(Rest2) of
                        {Ns2, NewRest2} ->
                            process_numbers(Ns1, fun(N1) ->
                                process_numbers(Ns2, fun(N2) ->
                                    Key = {D1 + N1, D2 + N2},
                                    maps:put(Key, true, Acc)
                                end, {Acc, false}, NewRest2)
                            end, {Acc, false}, NewRest1)
                    end
            end;
        {[C1 | Rest1], []} when C1 >= $a, C1 =< $z ->
            case D2 > 0 of
                true ->
                    Key = {D1, D2 - 1},
                    {maps:put(Key, true, Acc), false};
                false ->
                    {Acc, false}
            end;
        {[], [C2 | Rest2]} when C2 >= $a, C2 =< $z ->
            case D1 > 0 of
                true ->
                    Key = {D1 - 1, D2},
                    {maps:put(Key, true, Acc), false};
                false ->
                    {Acc, false}
            end;
        {[C1 | Rest1], []} when C1 >= $0, C1 =< $9 ->
            case get_numbers(Rest1) of
                {Ns, NewRest1} ->
                    process_numbers(Ns, fun(N) ->
                        Key = {D1 + N, D2},
                        maps:put(Key, true, Acc)
                    end, {Acc, false}, NewRest1)
            end;
        {[], [C2 | Rest2]} when C2 >= $0, C2 =< $9 ->
            case get_numbers(Rest2) of
                {Ns, NewRest2} ->
                    process_numbers(Ns, fun(N) ->
                        Key = {D1, D2 + N},
                        maps:put(Key, true, Acc)
                    end, {Acc, false}, NewRest2)
            end;
        _ ->
            {Acc, false}
    end.

get_numbers(Str) ->
    get_numbers(Str, 0, []).

get_numbers([C | Rest], N, Acc) when C >= $0, C =< $9 ->
    get_numbers(Rest, N * 10 + (C - $0), Acc);
get_numbers(Rest, N, Acc) ->
    {lists:reverse([N | Acc]), Rest}.

process_numbers([], _Fun, Acc, _Rest, _C, _D) -> Acc;
process_numbers([N | Ns], Fun, {MapAcc, Found}, Rest, C, D) ->
    NewMapAcc = Fun(N),
    process_numbers(Ns, Fun, {NewMapAcc, Found}, Rest, C, D).

process_numbers([], _Fun, Acc, _Rest) -> Acc;
process_numbers([N | Ns], Fun, {MapAcc, Found}, Rest) ->
    NewMapAcc = Fun(N),
    process_numbers(Ns, Fun, {NewMapAcc, Found}, Rest).