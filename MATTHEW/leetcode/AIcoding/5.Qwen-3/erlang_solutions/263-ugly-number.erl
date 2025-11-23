-module(ugly).
-export([is_ugly/1]).

is_ugly(N) when N =< 0 -> false;
is_ugly(N) -> is_ugly(N, 2, 3, 5).

is_ugly(N, 2, 3, 5) ->
    case N of
        1 -> true;
        _ ->
            case (N rem 2 == 0) or (N rem 3 == 0) or (N rem 5 == 0) of
                true ->
                    is_ugly(N div 2, 2, 3, 5);
                false -> false
            end
    end.