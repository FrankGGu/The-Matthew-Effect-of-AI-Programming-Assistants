-module(longest_awesome).
-export([longest_awesome/1]).

longest_awesome(S) ->
    longest_awesome(S, 0, #{0 => -1}, 0, 0).

longest_awesome([], _, _, Max, _) ->
    Max;
longest_awesome([H|T], I, Seen, Max, Mask) ->
    Digit = H - $0,
    NewMask = Mask bxor (1 bsl Digit),
    case maps:is_key(NewMask, Seen) of
        true ->
            NewMax = max(Max, I - maps:get(NewMask, Seen));
            longest_awesome(T, I + 1, Seen, NewMax, NewMask);
        false ->
            Closest = lists:foldl(fun (J, Acc) ->
                                         CurMask = NewMask bxor (1 bsl J),
                                         case maps:is_key(CurMask, Seen) of
                                             true ->
                                                 max(Acc, I - maps:get(CurMask, Seen));
                                             false ->
                                                 Acc
                                         end
                                 end, 0, lists:seq(0, 9)),
            NewMax = max(Max, Closest),
            NewSeen = maps:put(NewMask, case maps:is_key(NewMask, Seen) of true -> maps:get(NewMask,Seen); false -> I end, Seen),
            longest_awesome(T, I + 1, NewSeen, NewMax, NewMask)
    end.