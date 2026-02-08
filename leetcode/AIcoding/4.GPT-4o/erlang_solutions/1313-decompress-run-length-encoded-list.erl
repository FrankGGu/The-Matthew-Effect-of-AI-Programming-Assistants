-module(solution).
-export([decompress/1]).

decompress(RLE) ->
    lists:flatmap(fun({Count, Value}) -> lists:duplicate(Count, Value) end, list_to_tuple(RLE)).