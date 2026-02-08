-module(odd_string_difference).
-export([odd_string_difference/1]).

odd_string_difference(Words) ->
  Diffs = lists:map(fun(Word) -> string_to_diff(Word) end, Words),
  case lists:nth(1, Diffs) of
    lists:nth(2, Diffs) ->
      case lists:all(fun(Diff) -> Diff =:= lists:nth(1, Diffs) end, lists:sublist(Diffs, 3)) of
        true -> lists:nth(3, Words);
        false ->
          case lists:all(fun(Diff) -> Diff =:= lists:nth(2, Diffs) end, lists:sublist(Diffs, 3)) of
            true -> lists:nth(1, Words);
            false ->
              lists:keyfind(hd(lists:sort([{Diff,Word} || {Diff,Word} <- lists:zip(Diffs,Words)])), 1, lists:zip(Diffs, Words))!!2
          end
      end;
    _ ->
      case lists:all(fun(Diff) -> Diff =:= lists:nth(1, Diffs) end, lists:sublist(Diffs, 2)) of
        true -> lists:nth(2, Words);
        false -> lists:nth(1, Words)
      end
  end.

string_to_diff(Word) ->
  string_to_diff_helper(Word, []).

string_to_diff_helper([], Acc) ->
  lists:reverse(Acc);
string_to_diff_helper([H1, H2 | T], Acc) ->
  Diff = H2 - H1,
  string_to_diff_helper([H2 | T], [Diff | Acc]);
string_to_diff_helper([_], Acc) ->
  lists:reverse(Acc).