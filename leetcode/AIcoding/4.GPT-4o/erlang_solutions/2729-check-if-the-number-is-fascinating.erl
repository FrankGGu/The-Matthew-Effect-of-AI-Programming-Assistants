-module(solution).
-export([fascinating/1]).

fascinating(N) ->
    N1 = N * 2,
    N2 = N * 3,
    Combined = integer_to_list(N) ++ integer_to_list(N1) ++ integer_to_list(N2),
    check_fascinating(Combined).

check_fascinating(List) ->
    UniqueDigits = lists:usort(List),
    DigitCount = length(UniqueDigits),
    case DigitCount of
        9 -> lists:all(fun(X) -> lists:member(integer_to_list(X), UniqueDigits) end, lists:seq(1, 9));
        _ -> false
    end.