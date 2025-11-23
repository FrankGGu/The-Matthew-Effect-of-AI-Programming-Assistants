-module(strong_password_checker).
-export([strongPasswordChecker/1]).

strongPasswordChecker(Password) ->
    Len = length(Password),
    Missing = missing_types(Password),
    case Len of
        L when L < 6 ->
            max(6 - Len, Missing);
        L when L >= 6, L < 10 ->
            Missing;
        _ ->
            Count = count_repeats(Password),
            Required = required_changes(Len, Count),
            max(Missing, Required)
    end.

missing_types(Password) ->
    HasLower = lists:any(fun(C) -> C >= $a andalso C =< $z end, Password),
    HasUpper = lists:any(fun(C) -> C >= $A andalso C =< $Z end, Password),
    HasDigit = lists:any(fun(C) -> C >= $0 andalso C =< $9 end, Password),
    3 - (if HasLower -> 1; true -> 0 end + if HasUpper -> 1; true -> 0 end + if HasDigit -> 1; true -> 0 end).

count_repeats(Password) ->
    count_repeats(Password, [], []).

count_repeats([], Acc, _) ->
    Acc;
count_repeats([C | T], [], []) ->
    count_repeats(T, [C], 1);
count_repeats([C | T], [Last | _] = Current, Count) ->
    if C == Last ->
        count_repeats(T, Current, Count + 1);
    true ->
        count_repeats(T, [C], 1)
    end.

required_changes(Len, Repeats) ->
    Required = lists:foldl(fun(Repeat, Acc) ->
        case Repeat of
            R when R >= 2 ->
                case R rem 3 of
                    0 -> Acc + 1;
                    _ -> Acc
                end;
            _ -> Acc
        end
    end, 0, Repeats),
    Required.

count_repeats(_, _, _, []) ->
    [];
count_repeats(Password, [C | T], Count, Acc) ->
    case lists:prefix([C], T) of
        {true, Rest} ->
            count_repeats(Password, Rest, Count + 1, Acc);
        _ ->
            count_repeats(Password, T, 1, [Count | Acc])
    end.