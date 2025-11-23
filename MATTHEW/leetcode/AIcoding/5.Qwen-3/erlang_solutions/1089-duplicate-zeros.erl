-module(duplicate_zeros).
-export([duplicate_zeros/1]).

duplicate_zeros(Arr) ->
    N = length(Arr),
    I = 0,
    duplicate_zeros(Arr, I, N).

duplicate_zeros(Arr, I, N) when I < N ->
    if
        element(I + 1, Arr) == 0 ->
            % Duplicate the zero
            NewArr = lists:sublist(Arr, I + 1) ++ [0] ++ lists:sublist(Arr, I + 1, N - I - 1),
            duplicate_zeros(NewArr, I + 2, N);
        true ->
            duplicate_zeros(Arr, I + 1, N)
    end;
duplicate_zeros(Arr, _, _) ->
    Arr.