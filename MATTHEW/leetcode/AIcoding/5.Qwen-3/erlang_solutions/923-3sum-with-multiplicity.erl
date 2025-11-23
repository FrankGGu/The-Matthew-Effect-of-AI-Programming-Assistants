-module(three_sum_with_multiplicity).
-export([three_sum/1]).

three_sum(Nums) ->
    three_sum(Nums, 0, 0, 0, 0, dict:new()).

three_sum([], _I, _J, _K, _Count, _Dict) ->
    _Count;

three_sum([N | T], I, J, K, Count, Dict) ->
    case dict:is_key(N, Dict) of
        true ->
            {J, K} = dict:fetch(N, Dict),
            NewCount = Count + J * K,
            three_sum(T, I+1, J, K, NewCount, Dict);
        false ->
            three_sum(T, I+1, J, K, Count, Dict)
    end.