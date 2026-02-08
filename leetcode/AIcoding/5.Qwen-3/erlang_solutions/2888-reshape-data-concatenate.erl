-module(reshape_data_concatenate).
-export([concatenate/2]).

concatenate(DF1, DF2) ->
    lists:append(DF1, DF2).