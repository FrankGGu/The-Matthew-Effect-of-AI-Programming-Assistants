-module(small_palindrome).
-export([main/0]).

main() ->
    Input = io:get_line(""),
    Str = string:strip(Input),
    Result = smallest_palindromic_rearrangement(Str),
    io:format("~s~n", [Result]).

smallest_palindromic_rearrangement(S) ->
    Count = lists:foldl(fun(C, Acc) -> dict:update_counter(C, 1, Acc) end, dict:new(), S),
    {OddChars, EvenChars} = lists:partition(fun({_, V}) -> V rem 2 /= 0 end, dict:to_list(Count)),
    case OddChars of
        [] ->
            make_palindrome(EvenChars, []);
        _ ->
            [OddChar | _] = OddChars,
            {Char, _} = OddChar,
            EvenCount = dict:update_counter(Char, -1, Count),
            EvenList = dict:to_list(EvenCount),
            {EvenChars2, _} = lists:partition(fun({_, V}) -> V rem 2 == 0 end, EvenList),
            Middle = [Char],
            Left = make_half(EvenChars2),
            Right = lists:reverse(Left),
            lists:flatten([Left ++ Middle ++ Right])
    end.

make_half([]) -> [];
make_half([{Char, Count} | T]) ->
    Half = lists:duplicate(Count div 2, Char),
    Half ++ make_half(T).

make_palindrome([], Acc) -> lists:reverse(Acc);
make_palindrome([{Char, Count} | T], Acc) ->
    Half = lists:duplicate(Count div 2, Char),
    make_palindrome(T, Acc ++ Half).