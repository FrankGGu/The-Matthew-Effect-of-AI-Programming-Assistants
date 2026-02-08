-spec largest_number(Nums :: [integer()]) -> unicode:unicode_binary().
largest_number(Nums) ->
    Nums
    |> lists:map(fun num_to_string/1)
    |> lists:sort(fun(A, B) -> compare_numbers(A, B) end)
    |> lists:reverse()
    |> lists:flatten()
    |> list_to_binary().

num_to_string(Num) -> 
    integer_to_list(Num).

compare_numbers(A, B) ->
    case lists:prefix(A, B) of
        true -> 0;
        false -> 
            case lists:prefix(B, A) of
                true -> 1;
                false -> 
                    if A > B -> -1; true -> 1 end
            end
    end.
