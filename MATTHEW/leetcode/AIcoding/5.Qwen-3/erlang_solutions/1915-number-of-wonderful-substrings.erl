-module(number_of_wonderful_substrings).
-export([wonderfulSubstrings/1]).

wonderfulSubstrings(S) ->
    Count = lists:foldl(fun(C, Acc) -> 
        case Acc of
            #{C := V} -> Acc#{C => V + 1};
            _ -> Acc#{C => 1}
        end
    end, #{}, S),
    Total = maps:fold(fun(_, V, Acc) -> Acc + V * (V - 1) div 2 end, 0, Count),
    CountMap = maps:fold(fun(Char, V, Acc) ->
        lists:foldl(fun(I, A) -> 
            case A of
                #{I := C} -> A#{I => C + 1};
                _ -> A#{I => 1}
            end
        end, Acc, [Char])
    end, #{}, Count),
    Total + maps:fold(fun(_, V, Acc) -> Acc + V * (V - 1) div 2 end, 0, CountMap).

wonderfulSubstrings(_S) -> 0.