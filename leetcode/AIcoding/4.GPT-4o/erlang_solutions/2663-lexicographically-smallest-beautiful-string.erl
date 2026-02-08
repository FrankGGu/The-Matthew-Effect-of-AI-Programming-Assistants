-module(solution).
-export([smallest_beautiful_string/2]).

smallest_beautiful_string(N, K) ->
    String = lists:duplicate(N, $a),
    Result = find_beautiful_string(String, N, K),
    lists:flatten(Result).

find_beautiful_string(String, N, K) ->
    case check_beautiful(String, N) of
        true -> String;
        false ->
            Next = next_string(String, N, K),
            find_beautiful_string(Next, N, K)
    end.

check_beautiful(String, N) ->
    lists:all(fun(I) ->
        case I of
            0 -> true;
            _ -> abs(lists:nth(I + 1, String) - lists:nth(I, String)) =< 1
        end
    end, lists:seq(0, N - 2)).

next_string(String, N, K) ->
    case increment_string(String, N, K) of
        {ok, NewString} -> NewString;
        {error} -> String
    end.

increment_string(String, N, K) ->
    case lists:last(String) of
        Last when Last < $a + K - 1 ->
            NewLast = Last + 1,
            {ok, lists:sublist(String, 1, N - 1) ++ [NewLast]};
        _ ->
            Incremented = increment_prefix(String, N, K),
            case Incremented of
                {ok, NewPrefix} -> {ok, NewPrefix ++ [lists:nth(N, NewPrefix) + 1]};
                {error} -> {error}
            end
    end.

increment_prefix(String, N, K) ->
    case lists:reverse(String) of
        [] -> {error};
        [H | T] ->
            case H of
                Last when Last < $a + K - 1 ->
                    {ok, lists:reverse([H + 1 | T])};
                _ ->
                    case increment_prefix(lists:reverse(T), N - 1, K) of
                        {ok, NewPrefix} -> {ok, lists:reverse([lists:nth(N, NewPrefix) + 1 | lists:tl(NewPrefix)])};
                        {error} -> {error}
                    end
            end
    end.