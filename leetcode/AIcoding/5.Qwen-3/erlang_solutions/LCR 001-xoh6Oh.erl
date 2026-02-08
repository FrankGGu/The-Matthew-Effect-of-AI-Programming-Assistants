-module(divide_two_numbers).
-export([divide/2]).

divide(Num, Den) ->
    divide(Num, Den, 0).

divide(Num, Den, Result) when Num < Den ->
    if
        (Num < 0 andalso Den > 0) orelse (Num > 0 andalso Den < 0) ->
            -Result;
        true ->
            Result
    end;
divide(Num, Den, Result) ->
    NewNum = Num - Den,
    NewResult = Result + 1,
    divide(NewNum, Den, NewResult).