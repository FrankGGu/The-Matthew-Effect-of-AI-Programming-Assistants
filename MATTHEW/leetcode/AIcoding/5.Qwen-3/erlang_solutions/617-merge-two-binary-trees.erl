-module(merge_two_binary_trees).
-export([merge/2]).

-include_lib("eunit/include/eunit.hrl").

merge(nil, nil) -> nil;
merge(nil, T2) -> T2;
merge(T1, nil) -> T1;
merge(#{} = T1, #{} = T2) ->
    #{
        val := T1#{}.val + T2#{}.val,
        left := merge(T1#{}.left, T2#{}.left),
        right := merge(T1#{}.right, T2#{}.right)
    };
merge(T1, T2) ->
    {T1_val, T1_left, T1_right} = T1,
    {T2_val, T2_left, T2_right} = T2,
    {T1_val + T2_val, merge(T1_left, T2_left), merge(T1_right, T2_right)}.