-spec num_jewels_in_stones(J :: unicode:unicode_binary(), S :: unicode:unicode_binary()) -> integer().
num_jewels_in_stones(J, S) ->
    Jewels = sets:from_list(binary_to_list(J)),
    Stones = binary_to_list(S),
    lists:foldl(fun(Stone, Count) -> 
        case sets:is_element(Stone, Jewels) of
            true -> Count + 1;
            false -> Count
        end
    end, 0, Stones).