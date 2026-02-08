-module(int_to_english).
-export([number_to_words/1]).

-define(LESS_THAN_20, ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"]).
-define(TENS, ["", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]).
-define(THOUSANDS, ["", "Thousand", "Million", "Billion"]).

number_to_words(0) -> "Zero";
number_to_words(Num) -> string:strip(helper(Num), right, $ ).

helper(0) -> "";
helper(Num) when Num < 20 -> lists:nth(Num + 1, ?LESS_THAN_20);
helper(Num) when Num < 100 -> string:strip(?TENS div 10 + 1 ++ " " ++ helper(Num rem 10), right, $ );
helper(Num) when Num < 1000 -> string:strip(lists:nth(Num div 100 + 1, ?LESS_THAN_20) ++ " Hundred " ++ helper(Num rem 100), right, $ );
helper(Num) ->
    Res = "",
    helper(Num, 0, Res).

helper(0, _, Res) -> Res;
helper(Num, I, Res) ->
    if
        Num rem 1000 =/= 0 ->
            NewRes = helper(Num rem 1000) ++ " " ++ lists:nth(I + 1, ?THOUSANDS) ++ " " ++ Res,
            helper(Num div 1000, I + 1, NewRes);
        true ->
            helper(Num div 1000, I + 1, Res)
    end.