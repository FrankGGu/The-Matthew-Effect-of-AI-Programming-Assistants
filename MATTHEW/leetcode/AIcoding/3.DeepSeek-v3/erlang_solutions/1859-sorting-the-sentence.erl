-spec sort_sentence(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
sort_sentence(S) ->
    Words = string:split(S, " ", all),
    Pairs = lists:map(fun(Word) ->
        {Index, Rest} = lists:split(byte_size(Word) - 1, Word),
        {binary_to_integer(Rest), Index}
    end, Words),
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A =< B end, Pairs),
    Result = lists:map(fun({_, Word}) -> Word end, Sorted),
    string:join(Result, " ").