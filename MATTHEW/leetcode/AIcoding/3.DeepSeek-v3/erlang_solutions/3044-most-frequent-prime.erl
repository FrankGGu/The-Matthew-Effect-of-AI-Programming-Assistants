-module(solution).
-export([most_frequent_prime/1]).

most_frequent_prime(Mat) ->
    Rows = length(Mat),
    Cols = length(hd(Mat)),
    Primes = lists:foldl(
        fun(I, Acc1) ->
            lists:foldl(
                fun(J, Acc2) ->
                    Acc2 ++ generate_numbers(Mat, I, J, Rows, Cols)
                end,
                Acc1,
                lists:seq(0, Cols - 1))
        end,
        [],
        lists:seq(0, Rows - 1)),
    PrimeCounts = count_primes(Primes),
    case PrimeCounts of
        [] -> -1;
        _ ->
            MaxCount = lists:max(maps:values(PrimeCounts)),
            Candidates = [P || {P, C} <- maps:to_list(PrimeCounts), C =:= MaxCount],
            lists:max(Candidates)
    end.

generate_numbers(Mat, I, J, Rows, Cols) ->
    Directions = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}],
    lists:foldl(
        fun({Di, Dj}, Acc) ->
            Acc ++ build_numbers(Mat, I, J, Di, Dj, Rows, Cols, [])
        end,
        [],
        Directions).

build_numbers(Mat, I, J, Di, Dj, Rows, Cols, Path) ->
    if
        I < 0; I >= Rows; J < 0; J >= Cols -> Path;
        true ->
            Num = lists:foldl(fun(X, Acc) -> Acc * 10 + (lists:nth(X, lists:nth(I + 1, Mat)) - $0) end, 0, lists:seq(1, length(Path) + 1)),
            NewPath = Path ++ [lists:nth(J + 1, lists:nth(I + 1, Mat))],
            build_numbers(Mat, I + Di, J + Dj, Di, Dj, Rows, Cols, NewPath)
    end.

count_primes(Numbers) ->
    lists:foldl(
        fun(N, Acc) ->
            if
                N < 2 -> Acc;
                true ->
                    case is_prime(N) of
                        true -> maps:update_with(N, fun(C) -> C + 1 end, 1, Acc);
                        false -> Acc
                    end
            end
        end,
        maps:new(),
        Numbers).

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(N) when N rem 2 =:= 0 -> false;
is_prime(N) -> is_prime(N, 3).

is_prime(N, K) when K * K > N -> true;
is_prime(N, K) when N rem K =:= 0 -> false;
is_prime(N, K) -> is_prime(N, K + 2).