-module(solution).
-export([findIntegers/1]).

findIntegers(0) -> 1;
findIntegers(N) ->
    Fib = make_fib_array(31), 

    Ans = 0,
    PrevIsOne = false, 

    Len = floor(math:log2(N)) + 1,

    find_integers_loop(N, Len - 1, Ans, PrevIsOne, Fib).

make_fib_array(Size) ->
    Array = array:new([{size, Size}, {fixed, true}]),
    Array1 = array:set(0, 1, Array),
    Array2 = array:set(1, 2, Array1),
    make_fib_array_fill(2, Size, Array2).

make_fib_array_fill(K, Size, Array) when K < Size ->
    ValK_1 = array:get(K-1, Array),
    ValK_2 = array:get(K-2, Array),
    NewArray = array:set(K, ValK_1 + ValK_2, Array),
    make_fib_array_fill(K+1, Size, NewArray);
make_fib_array_fill(_K, _Size, Array) -> 
    Array.

find_integers_loop(N, I, Ans, PrevIsOne, Fib) when I >= 0 ->
    Bit = (N bsr I) band 1, 

    NewAns = 
        if Bit == 1 ->
            Ans + array:get(I, Fib); 
        true ->
            Ans
        end,

    if Bit == 1 and PrevIsOne == true ->
        NewAns; 
    else
        NextPrevIsOne = 
            if Bit == 1 ->
                true;
            true ->
                false
            end,
        find_integers_loop(N, I - 1, NewAns, NextPrevIsOne, Fib)
    end;

find_integers_loop(_N, _I, Ans, _PrevIsOne, _Fib) -> 
    Ans + 1.