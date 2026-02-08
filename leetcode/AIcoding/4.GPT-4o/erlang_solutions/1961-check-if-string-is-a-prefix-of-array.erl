-module(solution).
-export([is_prefix/2]).

is_prefix(Prefix, Arr) ->
    PrefixLength = length(Prefix),
    ArrLength = length(Arr),
    if
        PrefixLength > ArrLength -> false;
        true -> lists:prefix(Arr, Prefix)
    end.