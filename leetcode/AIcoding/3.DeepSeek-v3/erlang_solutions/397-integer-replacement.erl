-spec integer_replacement(N :: integer()) -> integer().
integer_replacement(N) when N =:= 1 -> 0;
integer_replacement(N) when N rem 2 =:= 0 -> 1 + integer_replacement(N div 2);
integer_replacement(N) when N =:= 2147483647 -> 32;
integer_replacement(N) -> 
    1 + min(integer_replacement(N + 1), integer_replacement(N - 1)).