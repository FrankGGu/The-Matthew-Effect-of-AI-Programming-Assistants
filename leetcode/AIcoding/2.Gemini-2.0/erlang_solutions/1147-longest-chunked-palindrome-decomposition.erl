-module(longest_chunked_palindrome_decomposition).
-export([longest_decomposition/1]).

longest_decomposition(Text) ->
    longest_decomposition_helper(Text, 0).

longest_decomposition_helper("", Count) ->
    Count;
longest_decomposition_helper(Text, Count) ->
    Len = length(Text),
    case find_palindrome_chunk(Text, Len) of
        none ->
            Count + 1;
        {ok, ChunkLen} ->
            Remaining = sub_string(Text, ChunkLen + 1, Len - 2 * ChunkLen),
            longest_decomposition_helper(Remaining, Count + 2)
    end.

find_palindrome_chunk(Text, Len) ->
    find_palindrome_chunk_helper(Text, Len, 1).

find_palindrome_chunk_helper(Text, Len, ChunkLen) when ChunkLen > Len div 2 ->
    none;
find_palindrome_chunk_helper(Text, Len, ChunkLen) ->
    Left = sub_string(Text, 1, ChunkLen),
    Right = sub_string(Text, Len - ChunkLen + 1, ChunkLen),
    if Left == Right then
        {ok, ChunkLen}
    else
        find_palindrome_chunk_helper(Text, Len, ChunkLen + 1)
    end.