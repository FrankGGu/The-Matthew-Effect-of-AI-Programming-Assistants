-module(p).
-export([otp/1]).

otp(secret) ->
  Time = trunc(erlang:now_ms() / 30000),
  Key = crypto:hmac(sha, secret, integer_to_list(Time)),
  Offset = Key band 15,
  P = (lists:nth(Offset + 1, Key) band 127) bsl 24 +
      (lists:nth(Offset + 2, Key) band 255) bsl 16 +
      (lists:nth(Offset + 3, Key) band 255) bsl 8 +
      (lists:nth(Offset + 4, Key) band 255),
  P rem 1000000.