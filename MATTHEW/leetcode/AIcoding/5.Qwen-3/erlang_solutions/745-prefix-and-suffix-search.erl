-module(prefix_suffix_search).
-export([new/1, search/2]).

-record(state, {words, trie}).

new(Words) ->
    Trie = build_trie(Words),
    #state{words = Words, trie = Trie}.

build_trie(Words) ->
    lists:foldl(fun(W, Acc) -> insert_word(Acc, W) end, dict:new(), Words).

insert_word(Trie, Word) ->
    Length = length(Word),
    lists:foldl(fun(I, T) ->
        Prefix = string:substr(Word, 1, I),
        Suffix = string:substr(Word, Length - I + 1),
        Key = {Prefix, Suffix},
        dict:update_counter(Key, 1, T)
    end, Trie, lists:seq(1, Length)).

search(#state{words = Words, trie = Trie}, Prefix, Suffix) ->
    Key = {Prefix, Suffix},
    case dict:find(Key, Trie) of
        {ok, _} -> find_max_index(Words, Prefix, Suffix);
        error -> -1
    end.

find_max_index(Words, Prefix, Suffix) ->
    lists:foldl(fun({Index, Word}, Acc) ->
        case (string:prefix(Word, Prefix) == Prefix) andalso (string:suffix(Word, Suffix) == Suffix) of
            true -> max(Index, Acc);
            false -> Acc
        end
    end, -1, lists:zip(lists:seq(0, length(Words)-1), Words)).