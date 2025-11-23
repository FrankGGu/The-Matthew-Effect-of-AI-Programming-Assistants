-module(prefix_and_suffix_search).
-export([new/1, f/3]).

-type word_list() :: [string()].
-type trie() :: #{
    value => integer(),
    children => #{char() => trie()}
}.

-record(ps_search, {trie = #{} :: trie(), words = [] :: word_list()}).

new(WORDS) ->
    #ps_search{trie = build_trie(WORDS), words = WORDS}.

f(OBJ, PREFIX, SUFFIX) ->
    #ps_search{trie = T, words = Words} = OBJ,
    find_best_index(T, Words, PREFIX, SUFFIX).

build_trie(WORDS) ->
    lists:foldl(fun(Word, Trie) ->
        build_trie_for_word(Word, lists:seq(1, length(Word)), Trie, length(Word))
    end, #{value => -1, children => #{}}, WORDS).

build_trie_for_word(Word, PosList, Trie, Index) ->
    lists:foldl(fun(Pos, AccTrie) ->
        build_trie_for_prefix_suffix(AccTrie, Word, Pos, Index)
    end, Trie, PosList).

build_trie_for_prefix_suffix(Trie, Word, Pos, Index) ->
    Prefix = string:sub_string(Word, 1, Pos),
    Suffix = string:sub_string(Word, Pos, length(Word) - Pos + 1),
    Key = Prefix ++ "{" ++ Suffix,
    build_trie_recursive(Trie, Key, Index, 1).

build_trie_recursive(Trie, Key, Index, Pos) ->
    case Pos > length(Key) of
        true ->
            Trie#{value => Index};
        false ->
            Char = string:sub_string(Key, Pos, 1),
            case maps:is_key(Char, maps:get(children, Trie, #{})) of
                true ->
                    Child = maps:get(Char, maps:get(children, Trie, #{})),
                    NewChild = build_trie_recursive(Child, Key, Index, Pos + 1),
                    Trie#{children => maps:put(Char, NewChild, maps:get(children, Trie, #{}))};
                false ->
                    NewChild = build_trie_recursive(#{value => -1, children => #{}}, Key, Index, Pos + 1),
                    Trie#{children => maps:put(Char, NewChild, maps:get(children, Trie, #{}))}
            end
    end.

find_best_index(Trie, Words, Prefix, Suffix) ->
    Key = Prefix ++ "{" ++ Suffix,
    find_best_index_recursive(Trie, Key, 1).

find_best_index_recursive(Trie, Key, Pos) ->
    case Pos > length(Key) of
        true ->
            maps:get(value, Trie, -1);
        false ->
            Char = string:sub_string(Key, Pos, 1),
            case maps:is_key(Char, maps:get(children, Trie, #{})) of
                true ->
                    Child = maps:get(Char, maps:get(children, Trie, #{})),
                    find_best_index_recursive(Child, Key, Pos + 1);
                false ->
                    -1
            end
    end.