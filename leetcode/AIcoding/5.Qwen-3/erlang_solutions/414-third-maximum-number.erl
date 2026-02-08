-module(third_max).
-export([third_max/1]).

third_max([]) -> undefined;
third_max([H | T]) ->
    Lists = lists:usort(T),
    case length(Lists) of
        0 -> H;
        1 -> H;
        2 -> H;
        _ -> lists:nth(3, lists:reverse(Lists))
    end.