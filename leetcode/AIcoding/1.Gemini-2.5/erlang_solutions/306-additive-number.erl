-module(solution).
-export([isAdditiveNumber/1]).

isAdditiveNumber(Num) ->
    TotalLen = length(Num),
    if
        TotalLen < 3 -> false;
        true -> check_all_splits(Num, TotalLen)
    end.

check_all_splits(Num, TotalLen) ->
    % Iterate through all possible lengths for the first number (N1_len)
    % N1_len must be at least 1.
    % It must leave at least 1 character for N2 and 1 for the rest of the sequence.
    lists:any(fun(N1_len) ->
        N1_str = string:substr(Num, 1, N1_len),
        % Check for leading zeros: if N1_len > 1 and the first character is '0', it's invalid.
        case N1_len > 1 andalso string:substr(N1_str, 1, 1) == "0" of
            true -> false; % Invalid N1 due to leading zero
            false ->
                N1 = list_to_integer(N1_str),
                % Iterate through all possible lengths for the second number (N2_len)
                % N2_len must be at least 1.
                % It must leave at least 1 character for the rest of the sequence.
                lists:any(fun(N2_len) ->
                    N2_str = string:substr(Num, N1_len + 1, N2_len),
                    % Check for leading zeros: if N2_len > 1 and the first character is '0', it's invalid.
                    case N2_len > 1 andalso string:substr(N2_str, 1, 1) == "0" of
                        true -> false; % Invalid N2 due to leading zero
                        false ->
                            N2 = list_to_integer(N2_str),
                            Remaining_start_index = N1_len + N2_len + 1,
                            Remaining_str = string:substr(Num, Remaining_start_index),
                            % Check if the rest of the string forms an additive sequence
                            is_additive_sequence(N1, N2, Remaining_str)
                    end
                end, lists:seq(1, TotalLen - N1_len - 1)) % N2_len max value
        end
    end, lists:seq(1, TotalLen - 2)). % N1_len max value

is_additive_sequence(_N1, _N2, "") ->
    % If the remaining string is empty, we have successfully formed an additive sequence
    true;
is_additive_sequence(N1, N2, RestOfNum) ->
    Sum = N1 + N2,
    Sum_str = integer_to_list(Sum),
    Sum_str_len = length(Sum_str),

    % If the remaining string is shorter than the sum string, it cannot be a match
    case length(RestOfNum) < Sum_str_len of
        true -> false;
        false ->
            % Extract the prefix of RestOfNum with the same length as Sum_str
            Prefix = string:substr(RestOfNum, 1, Sum_str_len),
            case Prefix == Sum_str of
                true ->
                    % If the prefix matches the sum, continue the sequence
                    New_RestOfNum = string:substr(RestOfNum, Sum_str_len + 1),
                    is_additive_sequence(N2, Sum, New_RestOfNum);
                false ->
                    % If the prefix does not match the sum, this path is not an additive sequence
                    false
            end
    end.