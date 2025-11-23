-module(jump_game_vii).
-export([can_reach/2]).

can_reach(S, MinJump, MaxJump) ->
  N = length(S),
  case S of
    [_ | _] ->
      can_reach_helper(S, MinJump, MaxJump, [0], N, 1, sets:new());
    [] ->
      false
  end.

can_reach_helper(S, MinJump, MaxJump, Q, N, Curr, Visited) ->
  case Q of
    [] ->
      false;
    [H | T] ->
      if
        H == N - 1 ->
          true;
        true ->
          NextQ = process_jumps(S, MinJump, MaxJump, H, N, Curr, Visited),
          can_reach_helper(S, MinJump, MaxJump, T ++ NextQ, N, Curr + 1, sets:union(Visited, sets:from_list(NextQ)))
      end
  end.

process_jumps(S, MinJump, MaxJump, Curr, N, Start, Visited) ->
  process_jumps_helper(S, MinJump, MaxJump, Curr, N, Start, Visited, []).

process_jumps_helper(S, MinJump, MaxJump, Curr, N, Start, Visited, Acc) ->
  if
    Start > Curr + MaxJump ->
      lists:reverse(Acc);
    Start >= Curr + MinJump andalso Start < N ->
      case lists:nth(Start + 1, S) of
        $0 ->
          case sets:is_element(Start, Visited) of
            true ->
              process_jumps_helper(S, MinJump, MaxJump, Curr, N, Start + 1, Visited, Acc);
            false ->
              process_jumps_helper(S, MinJump, MaxJump, Curr, N, Start + 1, Visited, [Start | Acc])
          end;
        $1 ->
          process_jumps_helper(S, MinJump, MaxJump, Curr, N, Start + 1, Visited, Acc)
      end;
    Start < N ->
      process_jumps_helper(S, MinJump, MaxJump, Curr, N, Start + 1, Visited, Acc);
    true ->
      lists:reverse(Acc)
  end.