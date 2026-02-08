-module(reformat_string).
-export([reformat_string/1]).

reformat_string(S) ->
  {Digits, Letters} = lists:foldl(
    fun(C, {Ds, Ls}) ->
      case C >= $0 andalso C =< $9 of
        true -> {[C|Ds], Ls};
        false -> {Ds, [C|Ls]}
      end
    end,
    {[], []},
    string:to_list(S)
  ),
  LD = length(Digits),
  LL = length(Letters),
  case abs(LD - LL) > 1 of
    true -> "";
    false ->
      case LD > LL of
        true -> interleave(Digits, Letters, []);
        false -> interleave(Letters, Digits, [])
      end
  end.

interleave([], [], Acc) ->
  lists:reverse(Acc);
interleave([D|Ds], [L|Ls], Acc) ->
  interleave(Ds, Ls, [D, L|Acc]);
interleave([D|Ds], [], Acc) ->
  interleave(Ds, [], [D|Acc]);
interleave([], [L|Ls], Acc) ->
  interleave([], Ls, [L|Acc]).