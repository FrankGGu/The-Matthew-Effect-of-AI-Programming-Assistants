-module(solution).
-export([longest_subarray/1]).

longest_subarray(A) ->
    longest_subarray(A, 0, 0, 0, 0).

longest_subarray([], _, MaxLen, _, _) -> 
    MaxLen;
longest_subarray([H | T], Prev, MaxLen, Count, Deleted) ->
    case H of
        1 -> 
            longest_subarray(T, Prev + 1, MaxLen, Count + 1, Deleted);
        0 -> 
            case Deleted of
                0 -> 
                    longest_subarray(T, 0, max(MaxLen, Prev + Count), Count + 1, 1);
                _ -> 
                    longest_subarray(T, 0, MaxLen, Count, Deleted)
            end
    end.