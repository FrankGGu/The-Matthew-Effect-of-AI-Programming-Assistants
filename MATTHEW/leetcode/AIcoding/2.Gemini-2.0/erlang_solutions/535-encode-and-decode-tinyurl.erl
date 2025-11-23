-module(tinyurl).
-export([encode/1, decode/1]).

-define(BASE, 62).
-define(ALPHABET, "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").

encode(LongUrl) ->
  Id = phash2:hash(LongUrl),
  encode_id(Id).

decode(ShortUrl) ->
  case string:str(ShortUrl, "http://tinyurl.com/") of
    0 ->
      case string:str(ShortUrl, "https://tinyurl.com/") of
        0 ->
          case string:str(ShortUrl, "tinyurl.com/") of
            0 ->
              "";
            _ ->
              EncodedId = string:substr(ShortUrl, string:len("tinyurl.com/") + 1, string:len(ShortUrl)),
              decode_id(EncodedId)
          end;
        _ ->
          EncodedId = string:substr(ShortUrl, string:len("https://tinyurl.com/") + 1, string:len(ShortUrl)),
          decode_id(EncodedId)
      end;
    _ ->
      EncodedId = string:substr(ShortUrl, string:len("http://tinyurl.com/") + 1, string:len(ShortUrl)),
      decode_id(EncodedId)
  end.

encode_id(Id) ->
  encode_id(Id, "").

encode_id(0, Acc) ->
  lists:reverse(Acc);
encode_id(Id, Acc) ->
  Index = Id rem ?BASE,
  Char = element(Index + 1, string:characters(?ALPHABET)),
  encode_id(Id div ?BASE, [Char | Acc]).

decode_id(EncodedId) ->
  decode_id(EncodedId, 0).

decode_id("", Acc) ->
  integer_to_list(Acc);
decode_id(EncodedId, Acc) ->
  Char = string:substr(EncodedId, 1, 1),
  Index = string:str(?ALPHABET, Char) - 1,
  NewAcc = Acc * ?BASE + Index,
  decode_id(string:substr(EncodedId, 2, string:len(EncodedId)), NewAcc).