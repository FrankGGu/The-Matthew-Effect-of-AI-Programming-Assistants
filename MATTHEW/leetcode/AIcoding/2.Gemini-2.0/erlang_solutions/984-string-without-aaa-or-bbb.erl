-module(string_without_aaa_bbb).
-export([strWithout3a3b/2]).

strWithout3a3b(A, B) ->
  strWithout3a3b(A, B, []).

strWithout3a3b(0, 0, Acc) ->
  lists:reverse(Acc);
strWithout3a3b(A, B, Acc) when A > B ->
  case length(Acc) >= 1 andalso lists:nth(1, Acc) == 'a' of
    true ->
      strWithout3a3b(A, B - 1, ['b' | Acc]);
    false ->
      case length(Acc) >= 2 andalso lists:nth(1, Acc) == 'a' andalso lists:nth(2, Acc) == 'a' of
        true ->
          strWithout3a3b(A, B - 1, ['b' | Acc]);
        false ->
          strWithout3a3b(A - 1, B, ['a' | Acc])
      end
  end;
strWithout3a3b(A, B, Acc) ->
  case length(Acc) >= 1 andalso lists:nth(1, Acc) == 'b' of
    true ->
      strWithout3a3b(A - 1, B, ['a' | Acc]);
    false ->
      case length(Acc) >= 2 andalso lists:nth(1, Acc) == 'b' andalso lists:nth(2, Acc) == 'b' of
        true ->
          strWithout3a3b(A - 1, B, ['a' | Acc]);
        false ->
          strWithout3a3b(A, B - 1, ['b' | Acc])
      end
  end.