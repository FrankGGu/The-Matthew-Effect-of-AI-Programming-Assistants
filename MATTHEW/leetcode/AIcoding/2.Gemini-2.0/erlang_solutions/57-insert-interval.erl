-module(insert_interval).
-export([insert/2]).

insert(Intervals, NewInterval) ->
  insert_helper(Intervals, NewInterval, []).

insert_helper([], NewInterval, Acc) ->
  lists:reverse(Acc) ++ [NewInterval];
insert_helper([Interval | Rest], NewInterval, Acc) ->
  case NewInterval of
    {NewStart, NewEnd} ->
      case Interval of
        {Start, End} ->
          case NewEnd < Start of
            true ->
              lists:reverse(Acc) ++ [NewInterval] ++ [Interval | Rest];
            false ->
              case NewStart > End of
                true ->
                  insert_helper(Rest, NewInterval, Acc ++ [Interval]);
                false ->
                  insert_merged(Rest, {min(NewStart, Start), max(NewEnd, End)}, Acc)
              end
          end
      end
  end.

insert_merged([], MergedInterval, Acc) ->
  lists:reverse(Acc) ++ [MergedInterval];
insert_merged([Interval | Rest], MergedInterval, Acc) ->
  case MergedInterval of
    {MergedStart, MergedEnd} ->
      case Interval of
        {Start, End} ->
          case MergedEnd < Start of
            true ->
              lists:reverse(Acc) ++ [MergedInterval] ++ [Interval | Rest];
            false ->
              case MergedStart > End of
                true ->
                  lists:reverse(Acc) ++ [MergedInterval] ++ [Interval | Rest];
                false ->
                  insert_merged(Rest, {min(MergedStart, Start), max(MergedEnd, End)}, Acc)
              end
          end
      end
  end.