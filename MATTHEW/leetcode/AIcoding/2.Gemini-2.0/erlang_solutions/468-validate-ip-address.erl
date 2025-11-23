-module(validate_ip_address).
-export([validIPAddress/1]).

validIPAddress(IP) ->
  case string:split(IP, ".", all) of
    Segments when length(Segments) == 4 ->
      case lists:all(fun(Segment) -> is_ipv4_segment(Segment) end, Segments) of
        true -> "IPv4";
        false ->
          case string:split(IP, ":", all) of
            Segments2 when length(Segments2) == 8 ->
              case lists:all(fun(Segment) -> is_ipv6_segment(Segment) end, Segments2) of
                true -> "IPv6";
                false -> "Neither"
              end;
            _ -> "Neither"
          end
      end;
    _ ->
      case string:split(IP, ":", all) of
        Segments when length(Segments) == 8 ->
          case lists:all(fun(Segment) -> is_ipv6_segment(Segment) end, Segments) of
            true -> "IPv6";
            false -> "Neither"
          end;
        _ -> "Neither"
      end
  end.

is_ipv4_segment(Segment) ->
  try
    Value = list_to_integer(Segment),
    case Value of
      V when V >= 0 and V <= 255 ->
        case length(Segment) > 1 andalso Segment:hd() == $0 of
          true -> false;
          false -> true
        end;
      _ -> false
    end
  catch
    _:_ -> false
  end.

is_ipv6_segment(Segment) ->
  case length(Segment) > 0 andalso length(Segment) <= 4 of
    true ->
      try
        _Value = list_to_integer("16#" ++ Segment),
        lists:all(fun(C) ->
                      (C >= $0 andalso C <= $9) orelse
                        (C >= $a andalso C <= $f) orelse
                        (C >= $A andalso C <= $F)
                  end, Segment) ;
      catch
        _:_ -> false
      end;
    false -> false
  end.