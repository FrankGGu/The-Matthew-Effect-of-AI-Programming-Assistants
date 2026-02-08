-module(solution).
-export([convert/3]).

convert(Value, Unit1, Unit2) ->
    Factor1 = unit_factor(Unit1),
    Factor2 = unit_factor(Unit2),
    Value * Factor2 / Factor1.

unit_factor("km") -> 1000;
unit_factor("m") -> 1;
unit_factor("cm") -> 0.01;
unit_factor("mm") -> 0.001;
unit_factor("ft") -> 0.3048;
unit_factor("in") -> 0.0254;
unit_factor("yard") -> 0.9144;
unit_factor("mile") -> 1609.34;
unit_factor(_) -> 1.