-module(solution).
-export([get_smallest_string/2]).

get_smallest_string(N, K) ->
    Result = lists:duplicate(N, $a),
    Remaining = K - N,
    lists:foldr(fun(_, Acc) ->
        case Remaining of
            R when R >= 25 -> 
                Remaining2 = R - 25,
                lists:hd(Acc) + 25, 
                [lists:hd(Acc) + 25 | tl(Acc)];
            R when R > 0 -> 
                Remaining2 = 0,
                lists:hd(Acc) + R, 
                [lists:hd(Acc) + R | tl(Acc)];
            _ -> 
                lists:hd(Acc), 
                Acc
        end
    end, Result, lists:seq(1, N)),
    lists:map(fun(X) -> integer_to_list(X) end, Result).