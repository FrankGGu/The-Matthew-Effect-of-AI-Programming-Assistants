-module(solution).
-export([strong_password_checker/1]).

-include_lib("stdlib/include/stdlib.hrl").

-spec strong_password_checker(binary()) -> integer().
strong_password_checker(Password) ->
    Pwd = binary_to_list(Password),
    Len = length(Pwd),
    HasLower = lists:any(fun is_lower/1, Pwd),
    HasUpper = lists:any(fun is_upper/1, Pwd),
    HasDigit = lists:any(fun is_digit/1, Pwd),
    MissingTypes = 3 - (if HasLower -> 1; true -> 0 end +
                        if HasUpper -> 1; true -> 0 end +
                        if HasDigit -> 1; true -> 0 end),
    RepeatFixes = count_repeats(Pwd),
    if
        Len < 6 ->
            max(MissingTypes, 6 - Len);
        Len =< 20 ->
            max(MissingTypes, RepeatFixes);
        true ->
            Over = Len - 20,
            FixAfterDel = fix_with_deletion(Pwd, Over),
            Over + max(MissingTypes, FixAfterDel)
    end.

is_lower(C) -> C >= $a andalso C =< $z.
is_upper(C) -> C >= $A andalso C =< $Z.
is_digit(C) -> C >= $0 andalso C =< $9.

count_repeats(Chars) ->
    count_repeats(Chars, 0, [], 0).

count_repeats([], _, _, Total) -> Total;
count_repeats([H|T], Prev, [H|Stack], Total) when length([H|Stack]) >= 2, H =:= Prev ->
    if
        length([H,H|Stack]) rem 3 =:= 2 ->
            count_repeats(T, H, [], Total + 1);
        true ->
            count_repeats(T, H, [H|Stack], Total)
    end;
count_repeats([H|T], _, _, Total) ->
    count_repeats(T, H, [H], Total).

fix_with_deletion(Chars, Del) ->
    Seqs = collect_repeats(Chars),
    Sorted = lists:sort(fun({A,_}, {B,_}) -> A < B end, Seqs),
    fix_deletion(Sorted, Del, 0).

collect_repeats(Chars) ->
    collect_repeats(Chars, [], 1, []).

collect_repeats([], _, _, Acc) -> Acc;
collect_repeats([C], Prev, Cnt, Acc) ->
    if Cnt >= 3 -> [{Cnt, C} | Acc]; true -> Acc end;
collect_repeats([C1,C2|T], Prev, Cnt, Acc) ->
    if
        C1 =:= C2 ->
            collect_repeats([C2|T], C1, Cnt + 1, Acc);
        true ->
            Acc1 = if Cnt >= 3 -> [{Cnt, C1} | Acc]; true -> Acc end,
            collect_repeats([C2|T], C2, 1, Acc1)
    end.

fix_deletion([], _, Fix) -> Fix;
fix_deletion([{Len, _} | T], 0, Fix) ->
    Fix + Len div 3 + fix_deletion(T, 0, 0);
fix_deletion([{Len, _} | T], Del, Fix) ->
    Use = min(Del, Len - 2),
    NewLen = Len - Use,
    fix_deletion(T, Del - Use, Fix + NewLen div 3).

min(A, B) when A < B -> A;
min(_, B) -> B.

max(A, B) when A > B -> A;
max(_, B) -> B.
