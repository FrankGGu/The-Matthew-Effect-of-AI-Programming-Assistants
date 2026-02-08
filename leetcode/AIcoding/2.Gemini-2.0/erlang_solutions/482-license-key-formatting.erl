-module(license_key_formatting).
-export([license_key_formatting/2]).

license_key_formatting(S, K) ->
  Formatted = format_key(string:uppercase(string:strip(S, both, "-")), K, []),
  string:join(lists:reverse(Formatted), "-").

format_key("", _, Acc) ->
  Acc;
format_key(Key, K, Acc) ->
  Len = length(Key),
  if Len >= K ->
    Chunk = string:sub(Key, Len - K + 1, K),
    format_key(string:sub(Key, 1, Len - K), K, [Chunk | Acc]);
  true ->
    [Key | Acc]
  end.