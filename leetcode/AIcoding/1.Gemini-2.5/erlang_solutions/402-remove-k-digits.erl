-module(solution).
-export([removeKdigits/2]).

removeKdigits(NumStr, K) ->
    Digits = string:to_list(NumStr),
    {ResultStack, FinalK} = remove_digits_recursive(Digits, K, []),

    FinalStack = if FinalK > 0 -> lists:droplast(ResultStack, FinalK);
                   true -> ResultStack
                end,

    CleanedStack = remove_leading_zeros(FinalStack),

    if CleanedStack == [] -> "0";
       true -> lists:reverse(CleanedStack)
    end.

remove_digits_recursive([], K, CurrentStack) ->
    {CurrentStack, K};
remove_digits_recursive([H|T], K, CurrentStack) ->
    case CurrentStack of
        [] ->
            remove_digits_recursive(T, K, [H]);
        [TopStackDigit|_] when K > 0 andalso H < TopStackDigit ->
            remove_digits_recursive([H|T], K - 1, tl(CurrentStack));
        _ ->
            remove_digits_recursive(T, K, [H|CurrentStack])
    end.

remove_leading_zeros(Stack) ->
    case lists:dropwhile(fun(Char) -> Char == $0 end, Stack) of
        [] -> [$0];
        NonZeroStack -> NonZeroStack
    end.