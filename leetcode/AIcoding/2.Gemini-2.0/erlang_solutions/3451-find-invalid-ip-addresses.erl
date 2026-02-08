-module(invalid_ip).
-export([invalid_ip_addresses/1]).

invalid_ip_addresses(S) ->
  invalid_ip_addresses(S, []).

invalid_ip_addresses(S, Acc) ->
  Len = length(S),
  case Len of
    Len when Len > 12 ->
      lists:reverse(Acc);
    Len when Len < 4 ->
      lists:reverse(Acc);
    _ ->
      invalid_ip_addresses(S, 1, [], Acc).

invalid_ip_addresses(_S, 4, Segments, Acc) ->
  IP = string:join(Segments, "."),
  lists:reverse([IP | Acc]);
invalid_ip_addresses(S, Count, Segments, Acc) ->
  Len = length(S),
  case Len of
    0 ->
      lists:reverse(Acc);
    _ ->
      invalid_ip_addresses_helper(S, Count, Segments, Acc).

invalid_ip_addresses_helper(S, Count, Segments, Acc) ->
  Len = length(S),
  case Len of
    0 ->
      lists:reverse(Acc);
    _ ->
      Results = lists:foldl(
                  fun(I, Acc2) ->
                    try
                      Sub = string:sub(S, 1, I),
                      case is_valid_segment(Sub) of
                        true ->
                          Rest = string:sub(S, I + 1, Len - I),
                          invalid_ip_addresses(Rest, Count + 1, [Sub | Segments], Acc2);
                        false ->
                          Acc2
                      end
                    catch
                      _:_ ->
                        Acc2
                    end
                  end,
                  Acc,
                  lists:seq(1, 3)),
      Results.

is_valid_segment(S) ->
  try
    Num = list_to_integer(S),
    case (length(S) > 1 andalso hd(S) == $0) of
      true ->
        false;
      false ->
        Num >= 0 andalso Num <= 255
    end
  catch
    _:_ ->
      false
  end.