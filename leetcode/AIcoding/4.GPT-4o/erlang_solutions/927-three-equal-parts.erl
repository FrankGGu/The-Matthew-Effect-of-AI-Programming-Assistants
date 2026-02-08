-module(solution).
-export([three_equal_parts/1]).

three_equal_parts(A) ->
    {Ones, N} = lists:foldl(fun(X, {Ones, N}) ->
        case X of
            1 -> {Ones + 1, N + 1};
            _ -> {Ones, N + 1}
        end
    end, {0, 0}, A),
    if
        Ones rem 3 =:= 0 ->
            case find_parts(A, Ones div 3, 0, 0) of
                {P1, P2, P3} ->
                    if P1 >= 0 andalso P2 >= 0 andalso P3 >= 0 ->
                        {P1, P2 + 1, P3 + 1};
                    true -> 
                        {-1, -1}
                    end;
                _ -> {-1, -1}
            end;
        true -> {-1, -1}
    end.

find_parts(_, 0, P1, P1) -> {P1, P1, P1};
find_parts(A, K, P1, P2) ->
    case A of
        [] -> {P1, P2, -1};
        [H | T] ->
            case H of
                1 -> 
                    if K > 0 -> 
                        find_parts(T, K - 1, P1 + 1, P2);
                    true -> 
                        find_parts(T, K, P1, P2 + 1)
                    end;
                _ -> 
                    find_parts(T, K, P1, P2)
            end
    end.