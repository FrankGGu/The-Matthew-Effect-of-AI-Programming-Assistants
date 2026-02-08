-module(frog_jump).
-export([can_cross/1]).

can_cross(Stones) ->
  can_cross(Stones, 0, 0, #{0 => [0]}).

can_cross([_], _, _, _) ->
  true;
can_cross(Stones, Stone, Jump, Reachable) ->
  case Reachable of
    #{Stone := Jumps} ->
      lists:any(
        fun(J) ->
          NewJumps = [J - 1, J, J + 1],
          lists:any(
            fun(NewJump) ->
              NewStone = Stone + NewJump,
              case lists:member(NewStone, Stones) of
                true ->
                  case Reachable of
                    #{NewStone := ExistingJumps} ->
                      case lists:member(NewJump, ExistingJumps) of
                        true ->
                          false;
                        false ->
                          can_cross(Stones, NewStone, NewJump, Reachable#{NewStone => [NewJump | ExistingJumps]})
                      end;
                    _ ->
                      can_cross(Stones, NewStone, NewJump, Reachable#{NewStone => [NewJump]})
                  end;
                false ->
                  false
              end
            end,
            NewJumps
          )
        end,
        Jumps
      );
    _ ->
      false
  end.