-spec checkIfExist(Arr :: [integer()]) -> boolean().
checkIfExist(Arr) ->
    checkIfExist_recursive(Arr, gb_sets:new()).

checkIfExist_recursive([], _Seen) ->
    false;
checkIfExist_recursive([N | Rest], Seen) ->
    % Check if N * 2 exists in the set of previously seen numbers
    case gb_sets:is_member(N * 2, Seen) of
        true ->
            true;
        false ->
            % If N is even, check if N / 2 exists in the set
            case N rem 2 == 0 of
                true ->
                    case gb_sets:is_member(N div 2, Seen) of
                        true ->
                            true;
                        false ->
                            % Neither N*2 nor N/2 found, add N to set and continue
                            checkIfExist_recursive(Rest, gb_sets:add_element(N, Seen))
                    end;
                false ->
                    % N is odd, so N/2 is not an integer, no need to check
                    checkIfExist_recursive(Rest, gb_sets:add_element(N, Seen))
            end
    end.