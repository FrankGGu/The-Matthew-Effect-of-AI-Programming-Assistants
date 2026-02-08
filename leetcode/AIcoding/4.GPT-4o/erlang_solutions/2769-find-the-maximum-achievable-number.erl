-module(solution).
-export([find_max_achievable_number/2]).

find_max_achievable_number(X, Y) ->
    X + 2 * Y.