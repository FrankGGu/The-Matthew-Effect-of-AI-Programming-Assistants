-module(string_compression).
-export([compress/1]).

compress(Chars) ->
  compress_helper(Chars, [], 1, []).

compress_helper([], Acc, Count, Result) ->
  reverse_chars(Result, Acc, Count);
compress_helper([H | T], Acc, Count, Result) ->
  case Acc of
    [] ->
      compress_helper(T, [H], Count, Result);
    [Last | _] ->
      if H == Last then
        compress_helper(T, [H | Acc], Count + 1, Result)
      else
        reverse_chars(Result, Acc, Count, compress_helper(T, [H], 1, []))
      end
  end.

reverse_chars(Result, Acc, Count) ->
  reverse_chars(Result, Acc, Count, []).

reverse_chars(Result, Acc, Count, Compressed) ->
  case Acc of
    [] ->
      lists:reverse(Compressed ++ Result);
    [H | _] ->
      if Count == 1 then
        reverse_chars(Result, [], 0, [H | Compressed])
      else
        reverse_chars(Result, [], 0, lists:flatten([integer_to_list(Count), H]) ++ Compressed)
      end
  end.