-module(construct_string).
-export([repeat_limited_string/2]).

repeat_limited_string(S, RepeatLimit) ->
  Chars = string:to_list(S),
  Counts = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, #{}, Chars),
  SortedChars = lists:sort(fun(A, B) -> A > B end, maps:keys(Counts)),
  build_string(SortedChars, Counts, RepeatLimit, []).

build_string([], _, _, Acc) ->
  lists:reverse(Acc);
build_string([Char|Rest], Counts, RepeatLimit, Acc) ->
  case maps:get(Char, Counts) of
    0 ->
      build_string(Rest, maps:remove(Char, Counts), RepeatLimit, Acc);
    Count ->
      ToTake = min(Count, RepeatLimit),
      NewCounts = maps:put(Char, Count - ToTake, Counts),
      NewAcc = lists:append(lists:duplicate(ToTake, Char), Acc),
      case Count - ToTake of
        0 ->
          build_string(Rest, maps:remove(Char, NewCounts), RepeatLimit, NewAcc);
        _ ->
          case Rest of
            [] ->
              lists:reverse(NewAcc);
            [NextChar|_] ->
              case maps:get(NextChar, NewCounts, 0) > 0 of
                true ->
                  build_string([NextChar, Char|Rest -- [NextChar]], NewCounts, RepeatLimit, NewAcc);
                false ->
                  lists:reverse(NewAcc)
              end
          end
      end
  end.