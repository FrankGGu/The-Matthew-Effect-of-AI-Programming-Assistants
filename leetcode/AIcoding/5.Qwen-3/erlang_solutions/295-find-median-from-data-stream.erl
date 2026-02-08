-module(median_finder).
-export([new/0, add_num/2, find_median/1]).

new() ->
    {[], []}.

add_num(Num, {Left, Right}) ->
    {NewLeft, NewRight} = insert(Num, Left, Right),
    {NewLeft, NewRight}.

insert(Num, Left, Right) when length(Left) == length(Right) ->
    {[Num | Left], Right};
insert(Num, Left, Right) ->
    {Left, [Num | Right]}.

find_median({Left, Right}) ->
    case length(Left) of
        Length when Length == length(Right) ->
            (lists:nth(Length + 1, Left) + lists:nth(1, Right)) / 2;
        _ ->
            lists:nth(1, Left)
    end.