-module(solution).
-export([reorderedPowerOf2/1]).

count_digits(Num) ->
    count_digits(Num, [0,0,0,0,0,0,0,0,0,0]).

count_digits(0, Counts) -> Counts;
count_digits(Num, Counts) ->
    Digit = Num rem 10,
    NewCounts = lists:replace_nth(Digit + 1, lists:nth(Digit + 1, Counts) + 1, Counts),
    count_digits(Num div 10, NewCounts).

reorderedPowerOf2(N) ->
    N_counts = count_digits(N),
    check_powers_of_2(1, N_counts).

check_powers_of_2(PowerOf2, N_counts) when PowerOf2 =< 1000000000 ->
    PowerOf2_counts = count_digits(PowerOf2),
    if
        PowerOf2_counts =:= N_counts -> true;
        true -> check_powers_of_2(PowerOf2 * 2, N_counts)
    end;
check_powers_of_2(_PowerOf2, _N_counts) ->
    false.