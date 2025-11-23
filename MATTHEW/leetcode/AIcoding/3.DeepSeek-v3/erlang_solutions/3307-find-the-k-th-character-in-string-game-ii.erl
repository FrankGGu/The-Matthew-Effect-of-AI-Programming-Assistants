-module(solution).
-export([find_kth_character/3]).

find_kth_character(S, K, M) ->
    N = length(S),
    TotalLen = total_length(N, M),
    if 
        K > TotalLen -> "";
        true -> find_char(S, K, M)
    end.

total_length(N, M) ->
    if 
        M == 0 -> N;
        true -> total_length(N, M - 1) * 2
    end.

find_char(S, K, M) ->
    N = length(S),
    if
        M == 0 -> lists:nth(K, S);
        true ->
            Half = total_length(N, M - 1),
            if
                K =< Half -> find_char(S, K, M - 1);
                true -> 
                    Char = find_char(S, K - Half, M - 1),
                    if 
                        Char == $0 -> $1;
                        Char == $1 -> $0;
                        true -> Char
                    end
            end
    end.