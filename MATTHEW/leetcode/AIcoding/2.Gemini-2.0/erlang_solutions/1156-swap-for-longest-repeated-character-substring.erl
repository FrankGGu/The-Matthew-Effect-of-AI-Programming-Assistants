-module(swap_for_longest_repeated_char_substring).
-export([maxRepOpt1/1]).

maxRepOpt1(Text) ->
  maxRepOpt1_helper(Text, 0).

maxRepOpt1_helper(Text, Acc) ->
  Counts = lists:foldl(
    fun(Char, Acc0) ->
      case maps:is_key(Char, Acc0) of
        true ->
          maps:update(Char, maps:get(Char, Acc0) + 1, Acc0);
        false ->
          maps:put(Char, 1, Acc0)
      end
    end,
    #{ },
    Text
  ),
  maxRepOpt1_main(Text, Counts, 0).

maxRepOpt1_main([], _Counts, MaxLen) ->
  MaxLen;
maxRepOpt1_main(Text, Counts, MaxLen) ->
  {Char, Len, Rest} = get_longest_repeated(Text),
  TotalCount = maps:get(Char, Counts),
  case Len < TotalCount of
    true ->
      case find_char_after(Rest, Char) of
        true ->
          NewLen = Len + 1;
        false ->
          NewLen = Len
      end;
    false ->
      NewLen = Len
  end,
  NewMaxLen = max(MaxLen, NewLen),
  case Rest of
    [] ->
      NewMaxLen;
    _ ->
      maxRepOpt1_main(Rest, Counts, NewMaxLen)
  end.

get_longest_repeated([]) ->
  {undefined, 0, []};
get_longest_repeated(Text) ->
  get_longest_repeated_helper(Text, hd(Text), 1, tl(Text)).

get_longest_repeated_helper([], Char, Len, Acc) ->
  {Char, Len, []};
get_longest_repeated_helper([H | T], Char, Len, Acc) ->
  case H == Char of
    true ->
      get_longest_repeated_helper(T, Char, Len + 1, Acc);
    false ->
      {Char, Len, [H | T]}
  end.

find_char_after([], _Char) ->
  false;
find_char_after([H | _T], Char) ->
  H == Char.