-module(solution).
-export([check_valid_partition/1]).

check_valid_partition(Nums) ->
    check_valid_partition(Nums, length(Nums), []).

check_valid_partition([], 0, _) -> 
    true;
check_valid_partition(Nums, N, _) when N < 0 -> 
    false;
check_valid_partition(Nums, N, _) ->
    case Nums of
        [A] when N >= 1, is_integer(A) -> 
            check_valid_partition(Nums, N - 1, [A | _]);
        [A, B] when N >= 2, A =:= B -> 
            check_valid_partition(Nums, N - 2, [A, B | _]);
        [A, B] when N >= 2, is_integer(A), is_integer(B) -> 
            check_valid_partition(Nums, N - 2, [A, B | _]);
        [A, B, C] when N >= 3, A =:= B, B =:= C -> 
            check_valid_partition(Nums, N - 3, [A, B, C | _]);
        [A, B, C] when N >= 3, A =:= B, is_integer(C) -> 
            check_valid_partition(Nums, N - 3, [A, B, C | _]);
        _ -> 
            false
    end.