-module(solution).
-export([wardrobe_organize/1]).

wardrobe_organize(Items) ->
    lists:sort(Items).