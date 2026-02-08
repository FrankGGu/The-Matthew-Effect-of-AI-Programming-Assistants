-module(most_frequent_prime).
-export([solve/1]).

solve(Mat) ->
    Rows = length(Mat),
    Cols = length(lists:nth(1, Mat)),
    Primes = find_primes(Mat, Rows, Cols),
    case Primes of
        [] -> -1;
        _ ->
            Counts = lists:foldl(fun(P, Acc) ->
                                         case maps:is_key(P, Acc) of
                                             true -> maps:update(P, maps:get(P, Acc) + 1, Acc);
                                             false -> maps:put(P, 1, Acc)
                                         end
                                 end, #{}, Primes),
            MaxCount = lists:max([maps:get(K, Counts) || K <- maps:keys(Counts)]),
            MaxPrimes = [K || K <- maps:keys(Counts), maps:get(K, Counts) == MaxCount],
            lists:max(MaxPrimes)
    end.

find_primes(Mat, Rows, Cols) ->
    lists:flatten([
        [try_all_directions(Mat, Row, Col, Rows, Cols) || Col <- lists:seq(1, Cols)] || Row <- lists:seq(1, Rows)
    ]).

try_all_directions(Mat, Row, Col, Rows, Cols) ->
    lists:flatten([
        try_direction(Mat, Row, Col, 0, 1, Rows, Cols),
        try_direction(Mat, Row, Col, 1, 0, Rows, Cols),
        try_direction(Mat, Row, Col, 1, 1, Rows, Cols),
        try_direction(Mat, Row, Col, 1, -1, Rows, Cols)
    ]).

try_direction(Mat, Row, Col, Dr, Dc, Rows, Cols) ->
    try_direction_helper(Mat, Row, Col, Dr, Dc, Rows, Cols, 0, []).

try_direction_helper(Mat, Row, Col, Dr, Dc, Rows, Cols, Num, Acc) ->
    if Row < 1 orelse Row > Rows orelse Col < 1 orelse Col > Cols ->
        case Num of
            0 -> [];
            _ ->
                case is_prime(Num) of
                    true -> [Num];
                    false -> []
                end
        end;
    true ->
        Digit = lists:nth(Col, lists:nth(Row, Mat)),
        NewNum = Num * 10 + Digit,
        try_direction_helper(Mat, Row + Dr, Col + Dc, Dr, Dc, Rows, Cols, NewNum, [NewNum | Acc])
    end.

is_prime(N) when N < 2 -> false;
is_prime(N) ->
    is_prime_helper(N, 2).

is_prime_helper(N, I) when I * I > N -> true;
is_prime_helper(N, I) ->
    if N rem I == 0 ->
        false;
    true ->
        is_prime_helper(N, I + 1)
    end.