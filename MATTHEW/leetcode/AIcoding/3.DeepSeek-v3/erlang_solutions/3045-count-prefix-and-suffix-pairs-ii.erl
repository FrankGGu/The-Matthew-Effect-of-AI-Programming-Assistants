-smodule(count_prefix_suffix_pairs).
-export([count_prefix_suffix_pairs/1]).

count_prefix_suffix_pairs(Words) ->
    Trie = #{},
    {_, Ans} = lists:foldl(fun(Word, {T, Acc}) ->
        {NewT, Cnt} = search_and_insert(T, Word),
        {NewT, Acc + Cnt}
    end, {Trie, 0}, Words),
    Ans.

search_and_insert(Trie, Word) ->
    N = length(Word),
    {NewTrie, Cnt} = lists:foldl(fun(I, {T, Acc}) ->
        Prefix = lists:sublist(Word, I),
        Suffix = lists:sublist(Word, N - I + 1, I),
        case Prefix =:= Suffix of
            true ->
                case maps:get(Prefix, T, 0) of
                    Val when is_integer(Val) ->
                        {maps:put(Prefix, Val + 1, T), Acc + Val};
                    _ ->
                        {T, Acc}
                end;
            false ->
                {T, Acc}
        end
    end, {Trie, 0}, lists:seq(1, N)),
    {NewTrie, Cnt}.