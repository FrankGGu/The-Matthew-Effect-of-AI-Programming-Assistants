-module(solution).
-export([min_cut/1]).

min_cut(S) ->
    Length = string:len(S),
    Is_Palindrome = lists:duplicate(Length, false),
    Cuts = lists:duplicate(Length, 0),
    lists:foreach(fun(I) -> 
        Min = I, 
        lists:foreach(fun(J) -> 
            if 
                J > I andalso is_palindrome(S, I, J, Is_Palindrome) -> 
                    Min = min(Min, Cuts:I-1 + 1)
            end
        end, lists:seq(0, I)),
        Cuts:I = Min
    end, lists:seq(0, Length - 1)),
    Cuts:Length - 1.

is_palindrome(S, Start, End, Is_Palindrome) ->
    if 
        Start >= End -> true;
        lists:nth(Start + 1, S) == lists:nth(End + 1, S) -> 
            Is_Palindrome:Start =:= true orelse (is_palindrome(S, Start + 1, End - 1, Is_Palindrome))
    end.