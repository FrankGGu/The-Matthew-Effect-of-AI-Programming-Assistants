-module(strong_password_checker).
-export([strong_password_checker/1]).

strong_password_checker(S) ->
    Len = length(S),
    Missing = missing_requirements(S),
    Repeating = repeating_characters(S),
    case Len < 6 of
        true ->
            max(Missing, 6 - Len);
        false ->
            case Len > 20 of
                true ->
                    Excess = Len - 20,
                    Cost = 0,
                    Repeating2 = lists:sort(fun({_, C1}, {_, C2}) -> C1 < C2 end, Repeating),
                    NewRepeating = lists:foldl(fun({Char, Count}, {AccCost, AccRepeating}) ->
                                                Diff = min(Excess, Count rem 3),
                                                NewExcess = Excess - Diff,
                                                NewCost = AccCost + Diff,
                                                case Count - Diff > 2 of
                                                    true ->
                                                        {[Char, Count - Diff] | AccRepeating, NewCost};
                                                    false ->
                                                        {AccRepeating, NewCost}
                                                end
                                        end, {[], 0}, Repeating2),
                    {Repeating3, Cost1} = NewRepeating,
                    Repeating4 = lists:sort(fun({_, C1}, {_, C2}) -> C1 < C2 end, Repeating3),
                    NewRepeating2 = lists:foldl(fun({Char, Count}, {AccCost, AccRepeating}) ->
                                                Diff = min(Excess div 3, Count div 3),
                                                NewExcess = Excess - Diff * 3,
                                                NewCost = AccCost + Diff,
                                                case Count - Diff * 3 > 2 of
                                                    true ->
                                                        {[Char, Count - Diff * 3] | AccRepeating, NewCost};
                                                    false ->
                                                        {AccRepeating, NewCost}
                                                end
                                        end, {[], Cost1}, Repeating4),
                    {Repeating5, Cost2} = NewRepeating2,
                    Cost3 = Cost2 + Excess - (Excess div 3) * 3,
                    max(Missing, Cost3);
                false ->
                    case Repeating of
                        [] ->
                            Missing;
                        _ ->
                            lists:sum([Count || {_, Count} <- Repeating]) + Missing
                    end
            end
    end.

missing_requirements(S) ->
    HasLower = lists:any(fun(C) -> C >= $a andalso C <= $z end, S),
    HasUpper = lists:any(fun(C) -> C >= $A andalso C <= $Z end, S),
    HasDigit = lists:any(fun(C) -> C >= $0 andalso C <= $9 end, S),
    (not HasLower) + (not HasUpper) + (not HasDigit).

repeating_characters(S) ->
    repeating_characters_helper(S, [], 0, $ , []).

repeating_characters_helper([], _, _, _, Acc) ->
    Acc;
repeating_characters_helper([H|T], Prev, Count, LastChar, Acc) ->
    case H == LastChar of
        true ->
            repeating_characters_helper(T, Prev, Count + 1, LastChar, Acc);
        false ->
            case Count > 2 of
                true ->
                    repeating_characters_helper(T, [H], 1, H, [{LastChar, Count} | Acc]);
                false ->
                    repeating_characters_helper(T, [H], 1, H, Acc)
            end
    end.