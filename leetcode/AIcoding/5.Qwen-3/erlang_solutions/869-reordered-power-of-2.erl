-module(reordered_power_of_2).
-export([reordered_power_of_two/1]).

reordered_power_of_two(N) ->
    IsPowerOfTwo = is_power_of_two(N),
    if
        IsPowerOfTwo ->
            true;
        true ->
            false
    end.

is_power_of_two(N) ->
    case N of
        0 -> false;
        _ ->
            Power = math:log(N) / math:log(2),
            IsInteger = erlang:is_integer(Power),
            if
                IsInteger ->
                    IsPowerOfTwo = (math:pow(2, floor(Power)) == N),
                    IsPowerOfTwo;
                true ->
                    false
            end
    end.

floor(X) when X >= 0 -> trunc(X);
floor(X) -> trunc(X - 1).