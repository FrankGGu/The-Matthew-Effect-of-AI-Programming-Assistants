-module(jump_game_iii).
-export([can_reach/2]).

can_reach(Arr, Start) ->
  can_reach(Arr, Start, orddict:new()).

can_reach(Arr, Start, Visited) ->
  case orddict:is_key(Start, Visited) of
    true ->
      false;
    false ->
      case lists:nth(Start + 1, Arr) == 0 of
        true ->
          true;
        false ->
          N = length(Arr),
          orddict:store(Start, true, Visited1) = orddict:store(Start, true, Visited),
          Next1 = Start + lists:nth(Start + 1, Arr),
          Next2 = Start - lists:nth(Start + 1, Arr),

          Cond1 = Next1 >= 0 andalso Next1 < N,
          Cond2 = Next2 >= 0 andalso Next2 < N,

          Result1 = case Cond1 of
                      true ->
                        can_reach(Arr, Next1, Visited1);
                      false ->
                        false
                    end,
          Result2 = case Cond2 of
                      true ->
                        can_reach(Arr, Next2, Visited1);
                      false ->
                        false
                    end,
          Result1 orelse Result2
      end
  end.