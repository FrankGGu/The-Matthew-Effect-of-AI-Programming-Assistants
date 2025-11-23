-module(int_to_english).
-export([number_to_words/1]).

number_to_words(N) when N == 0 -> "Zero";
number_to_words(N) ->
    translate(N, []).

translate(0, Acc) -> lists:reverse(Acc);
translate(N, Acc) ->
    case N of
        _ when N >= 1000000000 ->
            translate(N div 1000000000, [<<"Billion">> | Acc]),
            translate(N rem 1000000000, Acc);
        _ when N >= 1000000 ->
            translate(N div 1000000, [<<"Million">> | Acc]),
            translate(N rem 1000000, Acc);
        _ when N >= 1000 ->
            translate(N div 1000, [<<"Thousand">> | Acc]),
            translate(N rem 1000, Acc);
        _ when N >= 100 ->
            translate(N div 100, [<<"Hundred">> | Acc]),
            translate(N rem 100, Acc);
        _ when N >= 20 ->
            translate(N - (N rem 10), [get_tens(N div 10) | Acc]),
            translate(N rem 10, Acc);
        _ when N >= 1 ->
            translate(N - 1, [get_ones(N) | Acc])
    end.

get_ones(1) -> <<"One">>;
get_ones(2) -> <<"Two">>;
get_ones(3) -> <<"Three">>;
get_ones(4) -> <<"Four">>;
get_ones(5) -> <<"Five">>;
get_ones(6) -> <<"Six">>;
get_ones(7) -> <<"Seven">>;
get_ones(8) -> <<"Eight">>;
get_ones(9) -> <<"Nine">>;
get_ones(10) -> <<"Ten">>;
get_ones(11) -> <<"Eleven">>;
get_ones(12) -> <<"Twelve">>;
get_ones(13) -> <<"Thirteen">>;
get_ones(14) -> <<"Fourteen">>;
get_ones(15) -> <<"Fifteen">>;
get_ones(16) -> <<"Sixteen">>;
get_ones(17) -> <<"Seventeen">>;
get_ones(18) -> <<"Eighteen">>;
get_ones(19) -> <<"Nineteen">>.

get_tens(2) -> <<"Twenty">>;
get_tens(3) -> <<"Thirty">>;
get_tens(4) -> <<"Forty">>;
get_tens(5) -> <<"Fifty">>;
get_tens(6) -> <<"Sixty">>;
get_tens(7) -> <<"Seventy">>;
get_tens(8) -> <<"Eighty">>;
get_tens(9) -> <<"Ninety">>.