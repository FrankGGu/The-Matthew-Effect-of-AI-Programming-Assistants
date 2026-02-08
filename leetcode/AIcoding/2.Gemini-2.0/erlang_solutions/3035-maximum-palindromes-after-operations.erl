-module(maximum_palindromes).
-export([max_palindromes_after_operations/1]).

max_palindromes_after_operations(S) ->
    Frequencies = lists:foldl(
        fun(C, Acc) ->
            case maps:is_key(C, Acc) of
                true -> maps:update(C, maps:get(C, Acc) + 1, Acc);
                false -> maps:put(C, 1, Acc)
            end
        end,
        #{},
        S
    ),

    EvenCount = lists:sum([V div 2 || V <- maps:values(Frequencies)]),

    EvenCount div 2.