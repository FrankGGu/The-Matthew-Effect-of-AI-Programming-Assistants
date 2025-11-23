-module(maximum_binary_string).
-export([maximum_binary_string/1]).

maximum_binary_string(Binary) ->
  maximum_binary_string(Binary, 0, 0, []).

maximum_binary_string([], Ones, Zeros, Acc) ->
  lists:reverse(Acc);
maximum_binary_string([H|T], Ones, Zeros, Acc) ->
  case H of
    $1 ->
      maximum_binary_string(T, Ones + 1, Zeros, [H|Acc]);
    $0 ->
      maximum_binary_string(T, Ones, Zeros + 1, [H|Acc])
  end.

maximum_binary_string(Binary) when is_list(Binary) ->
    Zeros = lists:foldl(fun(C, Acc) -> if C == $0 -> Acc + 1; true -> Acc end end, 0, Binary),
    if Zeros == 0 then
        Binary
    else
        Len = length(Binary),
        lists:duplicate(Len - Zeros, $1) ++ lists:duplicate(1, $0) ++ lists:duplicate(Zeros - 1, $1)
    end.