-module(solution).
-export([len_longest_fib_subseq/1]).

len_longest_fib_subseq(Nums) ->
    len_longest_fib_subseq(Nums, 0, 1, dict:new()).

len_longest_fib_subseq([], _I, _J, _Dict) ->
    0;
len_longest_fib_subseq([_], _I, _J, _Dict) ->
    0;
len_longest_fib_subseq([A, B | T], I, J, Dict) ->
    Key = {B, A},
    case dict:is_key(Key, Dict) of
        true ->
            Current = dict:fetch(Key, Dict),
            Max = max(Current, 2),
            NewDict = dict:store({B, A}, Max, Dict),
            len_longest_fib_subseq([B | T], J, 0, NewDict);
        false ->
            NewDict = dict:store({B, A}, 2, Dict),
            len_longest_fib_subseq([B | T], J, 0, NewDict)
    end.