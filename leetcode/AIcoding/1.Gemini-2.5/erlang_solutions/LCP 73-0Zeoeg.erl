-module(stream_checker).
-export([new/1, query/2]).

new(Words) ->
    Trie = build_trie(Words),
    MaxWordLen = lists:foldl(fun(W, Max) -> max(length(W), Max) end, 0, Words),
    #{trie => Trie, stream => [], max_len => MaxWordLen, current_len => 0}.

query(Letter, State) ->
    Trie = maps:get(trie, State),
    OldStream = maps:get(stream, State),
    MaxLen = maps:get(max_len, State),
    CurrentLen = maps:get(current_len, State),

    NewStream = [Letter | OldStream],
    NewCurrentLen = CurrentLen + 1,

    {TrimmedStream, FinalLen} = if NewCurrentLen > MaxLen ->
                                    {lists:droplast(NewStream), MaxLen};
                                true ->
                                    {NewStream, NewCurrentLen}
                                end,

    Found = check_stream_for_match(TrimmedStream, Trie),

    {Found, maps:put(stream, TrimmedStream, maps:put(current_len, FinalLen, State))}.

build_trie(Words) ->
    lists:foldl(fun(Word, TrieAcc) ->
        insert_reversed_word(lists:reverse(Word), TrieAcc)
    end, #{}, Words).

insert_reversed_word(Chars, Trie) ->
    insert_reversed_word_recursive(Chars, Trie).

insert_reversed_word_recursive([], Node) ->
    maps:put('$end$', true, Node);
insert_reversed_word_recursive([Char | Rest], Node) ->
    ChildNode = maps:get(Char, Node, #{}),
    UpdatedChildNode = insert_reversed_word_recursive(Rest, ChildNode),
    maps:put(Char, UpdatedChildNode, Node).

check_stream_for_match(Stream, Trie) ->
    check_stream_for_match_recursive(Stream, Trie).

check_stream_for_match_recursive([], CurrentNode) ->
    maps:is_key('$end$', CurrentNode);
check_stream_for_match_recursive([Char | Rest], CurrentNode) ->
    case maps:is_key('$end$', CurrentNode) of
        true ->
            true;
        false ->
            case maps:find(Char, CurrentNode) of
                {ok, ChildNode} ->
                    check_stream_for_match_recursive(Rest, ChildNode);
                error ->
                    false
            end
    end.