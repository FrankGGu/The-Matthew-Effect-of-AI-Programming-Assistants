-spec gray_code(N :: integer()) -> [integer()].
gray_code(N) -> 
    gray_code(N, 0, []).

gray_code(0, _, Acc) -> lists:reverse(Acc);
gray_code(N, Val, Acc) -> 
    gray_code(N - 1, Val bsr 1, [Val | Acc]).
