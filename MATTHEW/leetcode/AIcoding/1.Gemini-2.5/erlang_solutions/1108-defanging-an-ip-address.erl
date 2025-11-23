-module(solution).
-export([defangIPaddr/1]).

-spec defangIPaddr(Address :: string()) -> string().
defangIPaddr(Address) ->
    defang(Address, []).

defang([], Acc) ->
    lists:reverse(Acc);
defang([$. | T], Acc) ->
    defang(T, [$] | [$. | [$ | Acc]]);
defang([H | T], Acc) ->
    defang(T, [H | Acc]).