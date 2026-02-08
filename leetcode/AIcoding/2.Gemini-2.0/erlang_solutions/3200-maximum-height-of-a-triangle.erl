-module(max_height).
-export([max_height/2]).

max_spec_height(Base, Area) ->
    Height = 2 * Area / Base,
    floor(Height).

max_height(Base, Area) ->
    max_spec_height(Base, Area).