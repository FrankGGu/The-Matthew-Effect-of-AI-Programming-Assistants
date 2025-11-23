-module(two_sum).
-export([two_sum/2]).

two_sum(Nums, Target) ->
    two_sum_impl(Nums, Target, 0, #{}).

two_sum_impl([Num | Rest], Target, Index, SeenMap) ->
    Complement = Target - Num,
    case maps:find(Complement, SeenMap) of
        {ok, ComplementIndex} ->
            [ComplementIndex, Index];
        _ ->
            NewSeenMap = maps:put(Num, Index, SeenMap),
            two_sum_impl(Rest, Target, Index + 1, NewSeenMap)
    end;
two_sum_impl([], _Target, _Index, _SeenMap) ->
    [].