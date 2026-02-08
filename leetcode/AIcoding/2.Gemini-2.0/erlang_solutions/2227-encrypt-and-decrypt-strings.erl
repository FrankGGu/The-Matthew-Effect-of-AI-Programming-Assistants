-module(encrypt_decrypt).
-export([encrypt/2, decrypt/2]).

encrypt(Key, Word1) ->
  encrypt_string(Word1, Key, []).

decrypt(Key, Word2) ->
  decrypt_string(Word2, Key, []).

encrypt_string([], _, Acc) ->
  lists:reverse(Acc);
encrypt_string([H|T], Key, Acc) ->
  case lists:keyfind(H, 1, Key) of
    {_, V} ->
      encrypt_string(T, Key, [V|Acc]);
    false ->
      encrypt_string(T, Key, Acc) % Should not happen according to the problem statement
  end.

decrypt_string([], _, Acc) ->
  lists:reverse(Acc);
decrypt_string(S, Key, Acc) ->
  case find_key_by_value(S, Key) of
    {_, K} ->
      decrypt_string(tl(S), Key, [K|Acc]);
    false ->
      decrypt_string(S, Key, Acc) % Should not happen according to the problem statement
  end.

find_key_by_value(S, Key) ->
  find_key_by_value(S, Key, 1).

find_key_by_value(S, Key, N) when N > length(Key) ->
  false;
find_key_by_value(S, Key, N) ->
  case lists:nth(N, Key) of
    {K, V} when V == hd(S) ->
      {N, K};
    _ ->
      find_key_by_value(S, Key, N + 1)
  end.