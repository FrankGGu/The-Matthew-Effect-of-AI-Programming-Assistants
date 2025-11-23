-module(word_search_ii).
-export([find_words/3]).

find_words(Board, Words) ->
    Trie = build_trie(Words),
    {Rows, Cols} = {length(Board), length(hd(Board))},
    Found = sets:new(),
    lists:foreach(
        fun(R) ->
            lists:foreach(
                fun(C) ->
                    dfs(Board, R, C, Rows, Cols, Trie, "", Found)
                end,
                lists:seq(0, Cols - 1)
            )
        end,
        lists:seq(0, Rows - 1)
    ),
    sets:to_list(Found).

build_trie(Words) ->
    lists:foldl(
        fun(Word, Trie) ->
            insert_word(Trie, Word)
        end,
        #{},
        Words
    ).

insert_word(Trie, []) ->
    Trie#{'$' => true};
insert_word(Trie, [C | Rest]) ->
    Next = maps:get(C, Trie, #{}),
    Trie#{C => insert_word(Next, Rest)}.

dfs(Board, R, C, Rows, Cols, Trie, Path, Found) ->
    case R >= 0 andalso R < Rows andalso C >= 0 andalso C < Cols of
        false -> ok;
        true ->
            Char = lists:nth(C + 1, lists:nth(R + 1, Board)),
            case maps:find(Char, Trie) of
                {ok, NextTrie} ->
                    NewPath = Path ++ [Char],
                    case maps:find('$', NextTrie) of
                        {ok, true} ->
                            sets:add_element(NewPath, Found);
                        _ -> ok
                    end,
                    NewBoard = mark_visited(Board, R, C),
                    lists:foreach(
                        fun({DR, DC}) ->
                            NewR = R + DR,
                            NewC = C + DC,
                            dfs(NewBoard, NewR, NewC, Rows, Cols, NextTrie, NewPath, Found)
                        end,
                        [{0, 1}, {1, 0}, {0, -1}, {-1, 0}]
                    );
                error -> ok
            end
    end.

mark_visited(Board, R, C) ->
    Row = lists:nth(R + 1, Board),
    NewRow = lists:sublist(Row, C) ++ [0] ++ lists:nthtail(C + 1, Row),
    lists:sublist(Board, R) ++ [NewRow] ++ lists:nthtail(R + 1, Board).