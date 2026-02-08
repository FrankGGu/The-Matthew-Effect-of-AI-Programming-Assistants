-module(greatest_english_letter).
-export([greatestLetter/1]).

greatestLetter(S) ->
    Letters = lists:usort([C || C <- S, (C >= $a andalso C =< $z) orelse (C >= $A andalso C =< $Z)]),
    lists:foldl(fun(C, Acc) ->
        case Acc of
            none -> {C, C};
            {MaxChar, MaxLower} ->
                Lower = if C >= $a -> C; true -> $0 end,
                Upper = if C >= $A -> C; true -> $0 end,
                Current = if Lower > $0 -> Lower; Upper > $0 -> Upper; true -> $0 end,
                if Current > MaxLower -> {C, Current}; true -> Acc end
        end
    end, none, Letters),
    case lists:foldl(fun(C, Acc) ->
        Lower = if C >= $a -> C; true -> $0 end,
        Upper = if C >= $A -> C; true -> $0 end,
        Current = if Lower > $0 -> Lower; Upper > $0 -> Upper; true -> $0 end,
        if Current > Acc -> Current; true -> Acc end
    end, $0, Letters) of
        $0 -> none;
        MaxChar -> [MaxChar]
    end.