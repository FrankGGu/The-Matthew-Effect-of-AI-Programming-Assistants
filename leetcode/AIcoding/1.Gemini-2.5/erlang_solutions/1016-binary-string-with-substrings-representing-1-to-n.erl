-module(solution).
-export([queryString/2]).
-include_lib("stdlib/include/gb_sets.hrl").

queryString(S, N) ->
    SubValues = gb_sets:new(),
    SubValues = generate_all_substring_values(S, N, SubValues),
    check_values(1, N, SubValues).

generate_all_substring_values(S, N, AccSet) ->
    case S of
        [] -> AccSet;
        [_H|T] -> % _H is not used, S is passed as is
            % Generate all substrings starting with the current head of S
            AccSet1 = generate_substring_values_from_prefix(S, N, 0, AccSet),
            % Recurse on the tail of S to find substrings starting at the next position
            generate_all_substring_values(T, N, AccSet1)
    end.

generate_substring_values_from_prefix(S_suffix, N, CurrentVal, AccSet) ->
    case S_suffix of
        [] -> AccSet;
        [H|T] ->
            Digit = H - $0, % Convert character '0' or '1' to integer 0 or 1
            NewVal = CurrentVal * 2 + Digit, % Calculate the new integer value

            % Optimization: If NewVal exceeds N, any further values generated
            % from this branch will also exceed N (since we are multiplying by 2
            % and adding a positive digit). So, we can stop early.
            if NewVal > N -> AccSet;
               true ->
                   NewAccSet = case NewVal of
                                   0 -> AccSet; % Ignore 0 as per problem constraints (1 to N)
                                   _ -> gb_sets:add(NewVal, AccSet)
                               end,
                   generate_substring_values_from_prefix(T, N, NewVal, NewAccSet)
            end
    end.

check_values(Current, N, SubValuesSet) when Current =< N ->
    case gb_sets:is_member(Current, SubValuesSet) of
        true -> check_values(Current + 1, N, SubValuesSet);
        false -> false % Current integer not found
    end;
check_values(_Current, _N, _SubValuesSet) ->
    true. % All integers from 1 to N have been checked and found