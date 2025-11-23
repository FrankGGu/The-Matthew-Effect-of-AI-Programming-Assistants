-module(solution).
-export([to_lower_case/1]).

-spec to_lower_case(S :: string()) -> string().
to_lower_case(S) ->
    [ case C of
          _ when C >= $A, C <= $Z -> C + 32;
          _ -> C
      end || C <- S ].