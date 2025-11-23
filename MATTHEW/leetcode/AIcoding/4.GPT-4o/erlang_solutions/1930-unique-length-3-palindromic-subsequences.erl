-module(solution).
-export([countPalindromes/1]).

countPalindromes(S) ->
    Length = string:length(S),
    Counts = maps:new(),
    lists:foreach(fun(I) ->
        lists:foreach(fun(J) ->
            if
                I < J -> 
                    Char1 = string:substr(S, I + 1, 1),
                    Char2 = string:substr(S, J + 1, 1),
                    if
                        Char1 =:= Char2 ->
                            Counts1 = maps:find(Char1, Counts, 0),
                            Counts2 = maps:find(Char2, Counts, 0),
                            NewCount = Counts1 + 1,
                            Counts2 = maps:put(Char1, NewCount, Counts)
                    end;
                true ->
                    ok
            end
        end, lists:seq(1, Length))
    end, lists:seq(1, Length)),
    maps:size(Counts).