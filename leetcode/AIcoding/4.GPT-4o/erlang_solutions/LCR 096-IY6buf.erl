-module(solution).
-export([is_interleave/3]).

is_interleave(S1, S2, S3) ->
    Len1 = string:length(S1),
    Len2 = string:length(S2),
    Len3 = string:length(S3),
    Len1 + Len2 =:= Len3 andalso
    is_interleave_helper(S1, S2, S3, Len1, Len2, Len3).

is_interleave_helper(_, _, _, 0, 0, 0) -> 
    true;
is_interleave_helper(S1, S2, S3, I1, I2, I3) -> 
    case I1 > 0 andalso string:nth(I3, S3) =:= string:nth(I1, S1) of
        true -> 
            is_interleave_helper(S1, S2, S3, I1 - 1, I2, I3 - 1);
        false -> 
            case I2 > 0 andalso string:nth(I3, S3) =:= string:nth(I2, S2) of
                true -> 
                    is_interleave_helper(S1, S2, S3, I1, I2 - 1, I3 - 1);
                false -> 
                    false
            end
    end.