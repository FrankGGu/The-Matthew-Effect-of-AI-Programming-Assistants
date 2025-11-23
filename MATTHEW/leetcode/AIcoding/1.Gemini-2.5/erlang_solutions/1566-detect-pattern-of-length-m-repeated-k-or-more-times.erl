-module(solution).
-export([detect_pattern/3]).

detect_pattern(Arr, M, K) ->
    N = length(Arr),
    RequiredLength = M * K,
    if
        RequiredLength > N ->
            false;
        true ->
            detect_pattern_loop(Arr, M, K, 0, N, RequiredLength)
    end.

detect_pattern_loop(Arr, M, K, I, N, RequiredLength) when I <= N - RequiredLength ->
    Pattern = lists:sublist(Arr, I + 1, M),
    case check_repetitions(Arr, I + 1 + M, Pattern, K - 1, M, N) of
        true ->
            true;
        false ->
            detect_pattern_loop(Arr, M, K, I + 1, N, RequiredLength)
    end;
detect_pattern_loop(_Arr, _M, _K, _I, _N, _RequiredLength) ->
    false.

check_repetitions(Arr, CurrentIndex, Pattern, RemainingK, M, N) ->
    if
        RemainingK == 0 ->
            true;
        CurrentIndex + M - 1 > N ->
            false;
        true ->
            NextPattern = lists:sublist(Arr, CurrentIndex, M),
            if
                NextPattern == Pattern ->
                    check_repetitions(Arr, CurrentIndex + M, Pattern, RemainingK - 1, M, N);
                true ->
                    false
            end
    end.