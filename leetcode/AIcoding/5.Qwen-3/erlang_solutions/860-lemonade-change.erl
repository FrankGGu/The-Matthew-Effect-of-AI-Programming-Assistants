-module(lemonade_change).
-export([lemonade_change/1]).

lemonade_change(Bills) ->
    {HasFive, HasTen} = lists:foldl(fun
        (5, {F, T}) -> {F+1, T};
        (10, {F, T}) when F > 0 -> {F-1, T+1};
        (10, {F, T}) -> {F, T};
        (20, {F, T}) when T > 0 andalso F > 0 -> {F-1, T-1};
        (20, {F, T}) when F >= 3 -> {F-3, T};
        (20, {F, T}) -> {F, T}
    end, {0, 0}, Bills),
    case {HasFive, HasTen} of
        {_, _} when HasFive < 0 orelse HasTen < 0 -> false;
        _ -> true
    end.