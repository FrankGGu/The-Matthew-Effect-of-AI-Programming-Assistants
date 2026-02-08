-module(solution).
-export([modify_string/1]).

modify_string(S) ->
    modify_string(S, []).

modify_string([], Acc) ->
    lists:reverse(Acc);
modify_string([$? | Rest], Acc) ->
    Prev = case Acc of
               [] -> none;
               [H | _] -> H
           end,
    Next = case Rest of
               [] -> none;
               [H | _] -> H
           end,
    Char = find_char(Prev, Next),
    modify_string(Rest, [Char | Acc]);
modify_string([C | Rest], Acc) ->
    modify_string(Rest, [C | Acc]).

find_char(none, none) -> $a;
find_char(none, Next) -> 
    if Next =/= $a -> $a;
       true -> $b
    end;
find_char(Prev, none) ->
    if Prev =/= $a -> $a;
       true -> $b
    end;
find_char(Prev, Next) ->
    lists:foldl(fun(C, Acc) ->
                    if C =/= Prev andalso C =/= Next -> C;
                       true -> Acc
                    end
                end, $a, "abc").