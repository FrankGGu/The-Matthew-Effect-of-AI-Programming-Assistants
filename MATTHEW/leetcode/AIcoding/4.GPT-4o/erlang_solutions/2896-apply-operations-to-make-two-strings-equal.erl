-module(solution).
-export([make_equal/2]).

make_equal(Str1, Str2) ->
    make_equal(string:to_list(Str1), string:to_list(Str2)).

make_equal([], []) -> true;
make_equal([], _) -> false;
make_equal(_, []) -> false;
make_equal([H1 | T1], [H2 | T2]) -> 
    if 
        H1 == H2 -> make_equal(T1, T2);
        true -> false 
    end.