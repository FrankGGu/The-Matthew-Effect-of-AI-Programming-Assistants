-module(count_numbers_with_non_decreasing_digits).
-export([num_of_non_decreasing_digits/1]).

num_of_non_decreasing_digits(N) ->
    count(0, N, 0, 0, []).

count(_N, 0, _Pos, _Last, _Digits) ->
    0;
count(N, 1, _Pos, _Last, _Digits) ->
    1;
count(N, K, Pos, Last, Digits) when K > 0 ->
    case Pos of
        0 ->
            count(N, K-1, Pos+1, 1, [1]);
        _ ->
            Total = 0,
            case Digits of
                [] ->
                    0;
                _ ->
                    lists:foldl(fun(D, Acc) ->
                                        if D >= Last ->
                                            Acc + count(N, K-1, Pos+1, D, [D]);
                                        true ->
                                            Acc
                                        end
                                 end, Total, lists:seq(Last, 9))
            end
    end.

num_of_non_decreasing_digits(N) ->
    Count = count(0, N, 0, 0, []),
    Count + 1.