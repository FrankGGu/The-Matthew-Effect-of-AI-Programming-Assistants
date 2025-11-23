-module(solution).
-export([num_squareful_perms/1]).

num_squareful_perms(A) ->
    case A of
        [] -> 0;
        _ ->
            Count = count_squareful(A, 0, length(A), []),
            Count
    end.

count_squareful([], _, 0, _) -> 1;
count_squareful(_, _, 0, _) -> 0;
count_squareful(A, Prev, N, Used) ->
    lists:foldl(fun(I, Acc) ->
        case lists:member(I, Used) of
            true -> Acc;
            false ->
                Num = lists:nth(I + 1, A),
                case Used == [] orelse is_square(Prev + Num) of
                    true ->
                        NewUsed = [I | Used],
                        Acc + count_squareful(A, Num, N - 1, NewUsed);
                    false -> Acc
                end
        end
    end, 0, lists:seq(0, length(A) - 1)).

is_square(N) when N < 0 -> false;
is_square(N) ->
    Root = round(math:sqrt(N)),
    Root * Root == N.