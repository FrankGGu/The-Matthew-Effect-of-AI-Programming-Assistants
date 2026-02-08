-module(employees_met_target).
-export([number_of_employees_met_target/2]).

number_of_employees_met_target(Hours, Target) ->
    lists:foldl(
      fun(Hour, Count) ->
              case Hour >= Target of
                  true -> Count + 1;
                  false -> Count
              end
      end,
      0,
      Hours
    ).