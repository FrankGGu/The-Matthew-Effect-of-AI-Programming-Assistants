-module(solution).
-export([str_without_3a3b/3]).

str_without_3a3b(N, K, A) when N =< 0 -> "";
str_without_3a3b(N, K, A) when K =< 0 -> "";
str_without_3a3b(N, K, A) ->
    str_without_3a3b(N, K, A, [], 0).

str_without_3a3b(0, _, _, Acc, _) ->
    lists:reverse(Acc);
str_without_3a3b(N, K, A, Acc, Count) ->
    case A of
        'a' ->
            if Count < 2 ->
                str_without_3a3b(N - 1, K, A, ['a' | Acc], Count + 1);
            true ->
                str_without_3a3b(N, K - 1, 'b', Acc, 0)
            end;
        'b' ->
            if Count < 2 ->
                str_without_3a3b(N - 1, K, A, ['b' | Acc], Count + 1);
            true ->
                str_without_3a3b(N, K - 1, 'a', Acc, 0)
            end
    end.