-module(solution).
-export([broken_calculator/2]).

broken_calculator(StartValue, Target) when Target =< StartValue ->
    StartValue - Target;
broken_calculator(StartValue, Target) when Target rem 2 == 0 ->
    1 + broken_calculator(StartValue, Target div 2);
broken_calculator(StartValue, Target) -> % Target rem 2 == 1 (odd)
    1 + broken_calculator(StartValue, Target + 1).