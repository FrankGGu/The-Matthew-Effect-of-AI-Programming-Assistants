-module(small_palindromic_rearrangement_ii).
-export([main/0]).

main() ->
    Input = io:get_line(""),
    Str = string:trim(Input),
    Result = smallest_palindromic_rearrangement(Str),
    io:format("~s~n", [Result]).

smallest_palindromic_rearrangement(Str) ->
    Count = count_chars(Str),
    {Odd, Even} = split_odd_even(Count),
    case Odd of
        [] ->
            make_palindrome(Even);
        _ ->
            MidChar = lists:keyfind(true, 2, Odd),
            Mid = element(1, MidChar),
            EvenWithoutMid = remove_char(Even, Mid),
            Left = make_palindrome(EvenWithoutMid),
            Right = lists:reverse(Left),
            [Mid | Left ++ Right]
    end.

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) -> 
                    maps:update_with(Char, fun(X) -> X + 1 end, 1, Acc)
                end, #{}, Str).

split_odd_even(Count) ->
    lists:partition(fun({_, V}) -> V rem 2 == 1 end, maps:to_list(Count)).

remove_char(List, Char) ->
    lists:foldl(fun({C, V}, Acc) ->
                    if C == Char -> 
                        if V > 1 -> [{C, V - 1} | Acc];
                           true -> Acc
                        end;
                       true -> [{C, V} | Acc]
                    end
                end, [], List).

make_palindrome(Chars) ->
    lists:foldl(fun({Char, Count}, Acc) ->
                    lists:duplicate(Count div 2, Char) ++ Acc
                end, [], Chars).