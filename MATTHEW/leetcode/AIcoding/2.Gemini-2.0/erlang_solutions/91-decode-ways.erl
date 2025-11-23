-module(decode_ways).
-export([num_decodings/1]).

num_decodings(S) ->
  num_decodings(S, []).

num_decodings("", Acc) ->
  num_decodings_helper("", Acc);
num_decodings(S, Acc) ->
  num_decodings_helper(S, Acc).

num_decodings_helper("", Acc) ->
  case Acc of
    [] -> 1;
    _ -> lists:last(Acc)
  end;
num_decodings_helper(S, Acc) ->
  N = length(S),
  case N of
    0 -> 1;
    1 ->
      case list_to_integer(S) of
        0 -> 0;
        _ ->
          if
            list_to_integer(S) >= 1 andalso list_to_integer(S) <= 9 ->
              case Acc of
                [] -> 1;
                _ -> lists:last(Acc)
              end;
            true -> 0
          end
      end;
    _ ->
      First = list_to_integer(lists:sublist(S, 1, 1)),
      Second = list_to_integer(lists:sublist(S, 1, 2)),
      Count1 = 0,
      Count2 = 0,

      if
        First >= 1 andalso First <= 9 ->
          case Acc of
            [] ->
              Count1 = num_decodings_helper(lists:sublist(S, 2, N - 1), [1]);
              true;
            _ ->
              Count1 = num_decodings_helper(lists:sublist(S, 2, N - 1), [lists:last(Acc)]);
              true
          end;
        true ->
          Count1 = 0
      end,

      if
        Second >= 10 andalso Second <= 26 ->
          case Acc of
            [] ->
              Count2 = num_decodings_helper(lists:sublist(S, 3, N - 2), [1]);
              true;
            _ ->
              Count2 = num_decodings_helper(lists:sublist(S, 3, N - 2), [lists:last(Acc)]);
              true
          end;
        true ->
          Count2 = 0
      end,
      Count1 + Count2
  end.