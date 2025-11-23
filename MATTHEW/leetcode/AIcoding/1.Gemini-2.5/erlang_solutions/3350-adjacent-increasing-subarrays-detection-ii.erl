-module(solution).
-export([can_split/1]).

can_split(List) ->
    Len = length(List),
    if Len < 2 ->
        false;
       true ->
        PrefixFlags = calculate_prefix_flags(List),
        SuffixFlags = calculate_suffix_flags(List),
        check_for_split(PrefixFlags, tl(SuffixFlags))
    end.

calculate_prefix_flags(List) ->
    calculate_prefix_flags_helper(List, none, true, []).

calculate_prefix_flags_helper([], _, _, Acc) ->
    lists:reverse(Acc);
calculate_prefix_flags_helper([H|T], none, _, Acc) ->
    calculate_prefix_flags_helper(T, H, true, [true | Acc]);
calculate_prefix_flags_helper([H|T], PrevVal, PrevIsIncreasing, Acc) ->
    IsCurrentIncreasing = PrevIsIncreasing andalso (H > PrevVal),
    calculate_prefix_flags_helper(T, H, IsCurrentIncreasing, [IsCurrentIncreasing | Acc]).

calculate_suffix_flags(List) ->
    {_, _, Flags} = lists:foldr(fun(Elem, {PrevElem, IsPrevSuffixInc, Acc}) ->
                                   case PrevElem of
                                       none -> {Elem, true, [true | Acc]};
                                       _ ->
                                           IsCurrentSuffixInc = IsPrevSuffixInc andalso (Elem < PrevElem),
                                           {Elem, IsCurrentSuffixInc, [IsCurrentSuffixInc | Acc]}
                                   end
                                 end, {none, true, []}, List),
    Flags.

check_for_split([P|_], []) -> false;
check_for_split([], _) -> false;
check_for_split([P|PT], [S|ST]) ->
    if P andalso S ->
        true;
       true ->
        check_for_split(PT, ST)
    end.