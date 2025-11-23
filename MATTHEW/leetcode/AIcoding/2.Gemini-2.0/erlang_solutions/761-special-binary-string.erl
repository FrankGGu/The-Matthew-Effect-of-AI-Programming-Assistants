-module(special_binary_string).
-export([make_largest_special/1]).

make_largest_special(S) ->
    make_largest_special_helper(string:to_list(S)).

make_largest_special_helper(S) ->
    make_largest_special_helper(S, []).

make_largest_special_helper([], Acc) ->
    list_to_binary(lists:flatten(lists:sort(fun(A, B) -> A > B end, lists:reverse(Acc))));
make_largest_special_helper(S, Acc) ->
    {Special, Rest} = find_special(S, 0, 0, []),
    make_largest_special_helper(Rest, [Acc, [list_to_binary(Special)]]).

find_special(S, Count, Index, Acc) ->
    case S of
        [] ->
            {Acc, []};
        [<<"1">> | Rest] ->
            find_special(Rest, Count + 1, Index + 1, [Acc, [<<"1">>]]) ;
        [<<"0">> | Rest] ->
            if Count - 1 == 0 then
                {[<<"1">>, list_to_binary(Acc), <<"0">>], Rest}
            else
                find_special(Rest, Count - 1, Index + 1, [Acc, [<<"0">>]])
            end
    end.