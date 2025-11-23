-module(solution).
-export([find_largest_almost_missing_integer/1]).

find_largest_almost_missing_integer(Nums) ->
    NumSet = sets:from_list(Nums),

    InitialMax = 0, % Assuming integers are non-negative or we are looking for the largest positive candidate.
                    % If negative candidates are possible and could be larger, this might need adjustment to a very small number.
                    % For typical LeetCode problems, positive integers are common.

    lists:foldl(fun(Num, AccMax) ->
                    Candidate = Num + 1,
                    case sets:is_element(Candidate, NumSet) of
                        true -> AccMax;
                        false -> max(AccMax, Candidate)
                    end
            end, InitialMax, Nums).