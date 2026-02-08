-module(solution).
-export([checkPossibility/1]).

checkPossibility(Nums) ->
    check_recursive(Nums, 0, -100001, -100001).

check_recursive([], _Count, _Prev, _PrevPrev) ->
    true;
check_recursive([H | T], Count, Prev, PrevPrev) ->
    if H >= Prev ->
        check_recursive(T, Count, H, Prev);
    else ->
        Count1 = Count + 1,
        if Count1 > 1 ->
            false;
        else ->
            if PrevPrev =< H ->
                check_recursive(T, Count1, H, Prev);
            else ->
                check_recursive(T, Count1, Prev, Prev)
            end
        end
    end.