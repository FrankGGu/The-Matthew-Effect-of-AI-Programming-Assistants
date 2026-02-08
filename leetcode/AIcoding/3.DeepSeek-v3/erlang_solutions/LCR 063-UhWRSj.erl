-module(solution).
-export([replace_words/2]).

replace_words(Dict, Sentence) ->
    Words = string:tokens(Sentence, " "),
    Trie = build_trie(Dict),
    Replaced = lists:map(fun(Word) -> replace_word(Word, Trie) end, Words),
    string:join(Replaced, " ").

build_trie(Dict) ->
    lists:foldl(fun(Word, Trie) -> insert_word(Word, Trie) end, dict:new(), Dict).

insert_word(Word, Trie) ->
    insert_word(Word, Word, Trie).

insert_word([], _, Trie) -> Trie;
insert_word([C|Rest], Original, Trie) ->
    case dict:find(C, Trie) of
        {ok, Child} ->
            case dict:find(is_end, Child) of
                {ok, true} -> Trie;
                error ->
                    NewChild = insert_word(Rest, Original, Child),
                    dict:store(C, NewChild, Trie)
            end;
        error ->
            NewChild = if Rest == [] -> dict:store(is_end, true, dict:new());
                         true -> insert_word(Rest, Original, dict:new())
                      end,
            dict:store(C, NewChild, Trie)
    end.

replace_word(Word, Trie) ->
    replace_word(Word, Trie, []).

replace_word([], _, Acc) -> lists:reverse(Acc);
replace_word([C|Rest], Trie, Acc) ->
    case dict:find(C, Trie) of
        {ok, Child} ->
            case dict:find(is_end, Child) of
                {ok, true} -> lists:reverse([C|Acc]);
                error -> replace_word(Rest, Child, [C|Acc])
            end;
        error -> lists:reverse(Acc) ++ [C|Rest]
    end.