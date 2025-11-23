-module(solution).
-export([number_of_employees_who_met_target/2]).

number_of_employees_who_met_target(Hours, Target) ->
    length([H || H <- Hours, H >= Target]).