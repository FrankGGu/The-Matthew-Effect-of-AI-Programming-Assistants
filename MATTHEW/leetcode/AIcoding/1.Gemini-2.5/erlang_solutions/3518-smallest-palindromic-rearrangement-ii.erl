-module(solution).
-export([solve/1]).

solve(S) ->
    FreqMap = count_frequencies(S),
    {OddChar, OddCount} = find_odd_char(FreqMap),

    case OddCount of
        0 -> 
            build_palindrome(FreqMap, undefined);
        1 -> 
            build_palindrome(FreqMap, OddChar);
        _ -> 
            []
    end.

count_frequencies(S) ->
    lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
    end, maps:new(), S).

find_odd_char(FreqMap) ->
    OddChars = maps:fold(fun(Char, Count, Acc) ->
        if Count rem 2 =:= 1 -> [Char | Acc];
           true -> Acc
        end
    end, [], FreqMap),

    case length(OddChars) of
        0 -> {undefined, 0};
        1 -> {hd(OddChars), 1};
        _ -> {undefined, length(OddChars)}
    end.

build_palindrome(FreqMap, MiddleChar) ->
    HalfList = build_half(FreqMap, MiddleChar),

    FirstHalf = lists:sort(HalfList),

    MiddlePart = case MiddleChar of
        undefined -> [];
        _ -> [MiddleChar]
    end,

    SecondHalf = lists:reverse(FirstHalf),

    lists:append([FirstHalf, MiddlePart, SecondHalf]).

build_half(FreqMap, MiddleChar) ->
    maps:fold(fun(Char, Count, Acc) ->
        NumToAdd = case {Char, MiddleChar} of
            {Char, Char} -> (Count - 1) div 2;
            _ -> Count div 2
        end,
        lists:duplicate(NumToAdd, Char) ++ Acc
    end, [], FreqMap).