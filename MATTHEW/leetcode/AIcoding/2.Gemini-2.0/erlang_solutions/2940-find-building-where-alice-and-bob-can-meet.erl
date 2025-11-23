-module(find_building).
-export([amount_of_buildings_can_see/1]).

amount_of_buildings_can_see(Heights) ->
    N = length(Heights),
    Result = lists:map(fun(I) -> solve(Heights, I) end, lists:seq(1, N)),
    Result.

solve(Heights, I) ->
    N = length(Heights),
    [A, B] = case I rem 2 of
                1 -> [alice(Heights, I), bob(Heights, I)];
                0 -> [bob(Heights, I), alice(Heights, I)]
             end,
    case A == B of
      true -> A;
      false -> -1
    end.

alice(Heights, I) ->
    N = length(Heights),
    AliceIndex = I,
    case I rem 2 of
        1 ->
            FirstGreater = find_first_greater(Heights, AliceIndex, N, 1);
        0 ->
            FirstGreater = find_first_greater(Heights, AliceIndex, 1, -1)
    end,
    FirstGreater.

bob(Heights, I) ->
    N = length(Heights),
    BobIndex = I,
    case I rem 2 of
        1 ->
            FirstGreater = find_first_greater(Heights, BobIndex, 1, -1);
        0 ->
            FirstGreater = find_first_greater(Heights, BobIndex, N, 1)
    end,
    FirstGreater.

find_first_greater(Heights, Start, End, Step) ->
    find_first_greater(Heights, Start, End, Step, element(Start, Heights), 1).

find_first_greater(Heights, Start, End, Step, Height, Count) ->
    case Start == End of
        true ->
            case element(End, Heights) > Height of
                true -> End;
                false -> -1
            end;
        false ->
            Next = Start + Step,
            case Next > length(Heights) orelse Next < 1 of
              true -> -1;
              false ->
                 case element(Next, Heights) > Height of
                    true -> Next;
                    false -> find_first_greater(Heights, Next, End, Step, Height, Count + 1)
                 end
            end
    end.