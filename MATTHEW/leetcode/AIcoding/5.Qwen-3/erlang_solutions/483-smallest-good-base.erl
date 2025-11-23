-module(solve).
-export([find_k/1]).

find_k(N) ->
    N_int = list_to_integer(N),
    find_k(N_int, 1, 2).

find_k(N, K, MaxK) ->
    case K of
        K when K > MaxK ->
            integer_to_list(N);
        _ ->
            case is_good_base(N, K) of
                true -> integer_to_list(K);
                false -> find_k(N, K + 1, MaxK)
            end
    end.

is_good_base(N, K) ->
    is_good_base(N, K, 1, 0).

is_good_base(N, K, Acc, Sum) ->
    case Acc of
        Acc when Acc > N ->
            false;
        _ ->
            NewSum = Sum + Acc,
            case NewSum of
                NewSum when NewSum == N -> true;
                _ when NewSum > N -> false;
                _ -> is_good_base(N, K, Acc * K, NewSum)
            end
    end.