-module(solution).
-export([maximum_beauty/1]).

maximum_beauty(Colors) ->
    lists:max([length(Colors) - lists:count(Colors, Color) || Color <- lists:usort(Colors)]).