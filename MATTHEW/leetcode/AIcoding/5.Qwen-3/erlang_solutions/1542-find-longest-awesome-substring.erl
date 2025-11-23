-module(solution).
-export([longest_awesome/1]).

longest_awesome(S) ->
    Max = 0,
    Map = #{},
    Map1 = maps:put(0, -1, Map),
    State = 0,
    longest_awesome(S, 0, State, Map1, Max).

longest_awesome([], _, _, _, Max) ->
    Max;

longest_awesome([C | T], Index, State, Map, Max) ->
    Digit = C - $0,
    NewState = State bxor (1 bsl Digit),
    case maps:find(NewState, Map) of
        {ok, Pos} ->
            CurrentLength = Index - Pos,
            NewMax = max(Max, CurrentLength),
            longest_awesome(T, Index + 1, NewState, Map, NewMax);
        error ->
            case maps:fold(fun(Key, Val, Acc) ->
                               if
                                   (Key bxor NewState) == 0 -> 
                                       max(Acc, Index - Val);
                                   (Key bxor NewState) == (1 bsl 0) ->
                                       max(Acc, Index - Val);
                                   (Key bxor NewState) == (1 bsl 1) ->
                                       max(Acc, Index - Val);
                                   (Key bxor NewState) == (1 bsl 2) ->
                                       max(Acc, Index - Val);
                                   (Key bxor NewState) == (1 bsl 3) ->
                                       max(Acc, Index - Val);
                                   (Key bxor NewState) == (1 bsl 4) ->
                                       max(Acc, Index - Val);
                                   (Key bxor NewState) == (1 bsl 5) ->
                                       max(Acc, Index - Val);
                                   (Key bxor NewState) == (1 bsl 6) ->
                                       max(Acc, Index - Val);
                                   (Key bxor NewState) == (1 bsl 7) ->
                                       max(Acc, Index - Val);
                                   (Key bxor NewState) == (1 bsl 8) ->
                                       max(Acc, Index - Val);
                                   (Key bxor NewState) == (1 bsl 9) ->
                                       max(Acc, Index - Val);
                                   true ->
                                       Acc
                               end
                           end, Max, Map) of
                NewMax ->
                    Map1 = maps:put(NewState, Index, Map),
                    longest_awesome(T, Index + 1, NewState, Map1, NewMax)
            end
    end.