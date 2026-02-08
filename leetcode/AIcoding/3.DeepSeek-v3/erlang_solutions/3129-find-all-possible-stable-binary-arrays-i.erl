-module(solution).
-export([number_of_stable_arrays/3]).

number_of_stable_arrays(Zero, One, Limit) ->
    Mod = 1000000007,
    DP = maps:new(),
    DP1 = maps:put({0, 0, 0, 0}, 1, DP),
    DP2 = solve(Zero, One, Limit, DP1, Mod),
    sum_maps(DP2, Mod).

solve(Zero, One, Limit, DP, Mod) ->
    case maps:size(DP) of
        0 -> DP;
        _ ->
            NewDP = maps:new(),
            {NewDP1, Changed} = process_entries(DP, NewDP, Zero, One, Limit, Mod),
            case Changed of
                true -> solve(Zero, One, Limit, NewDP1, Mod);
                false -> NewDP1
            end
    end.

process_entries(DP, NewDP, Zero, One, Limit, Mod) ->
    maps:fold(fun(Key, Val, {Acc, Changed}) ->
        {Z, O, ConsecZ, ConsecO} = Key,
        {NewAcc, NewChanged} = case {Z < Zero, O < One} of
            {true, true} ->
                case ConsecZ < Limit of
                    true ->
                        NewKey1 = {Z + 1, O, ConsecZ + 1, 0},
                        NewAcc1 = update_map(NewKey1, Val, Acc, Mod),
                        {NewAcc2, Changed2} = case ConsecO < Limit of
                            true ->
                                NewKey2 = {Z, O + 1, 0, ConsecO + 1},
                                {update_map(NewKey2, Val, NewAcc1, Mod), true};
                            false ->
                                {NewAcc1, Changed}
                        end,
                        {NewAcc2, true orelse Changed2};
                    false ->
                        case ConsecO < Limit of
                            true ->
                                NewKey2 = {Z, O + 1, 0, ConsecO + 1},
                                {update_map(NewKey2, Val, Acc, Mod), true};
                            false ->
                                {Acc, Changed}
                        end
                end;
            {true, false} ->
                case ConsecZ < Limit of
                    true ->
                        NewKey1 = {Z + 1, O, ConsecZ + 1, 0},
                        {update_map(NewKey1, Val, Acc, Mod), true};
                    false ->
                        {Acc, Changed}
                end;
            {false, true} ->
                case ConsecO < Limit of
                    true ->
                        NewKey2 = {Z, O + 1, 0, ConsecO + 1},
                        {update_map(NewKey2, Val, Acc, Mod), true};
                    false ->
                        {Acc, Changed}
                end;
            {false, false} ->
                {Acc, Changed}
        end,
        {NewAcc, NewChanged orelse Changed}
    end, {NewDP, false}, DP).

update_map(Key, Val, Map, Mod) ->
    case maps:is_key(Key, Map) of
        true ->
            Current = maps:get(Key, Map),
            maps:put(Key, (Current + Val) rem Mod, Map);
        false ->
            maps:put(Key, Val rem Mod, Map)
    end.

sum_maps(Map, Mod) ->
    maps:fold(fun(Key, Val, Acc) ->
        {Z, O, _, _} = Key,
        case {Z, O} of
            {_, _} -> (Acc + Val) rem Mod
        end
    end, 0, Map).