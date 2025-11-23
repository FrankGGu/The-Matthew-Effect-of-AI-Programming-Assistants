-module(solution).
-export([is_fascinating/1]).

is_fascinating(N) ->
    N2 = 2 * N,
    N3 = 3 * N,
    S = integer_to_list(N) ++ integer_to_list(N2) ++ integer_to_list(N3),

    case length(S) of
        9 ->
            case lists:member($0, S) of
                true -> false;
                false ->
                    lists:sort(S) == "123456789"
            end;
        _ ->
            false
    end.