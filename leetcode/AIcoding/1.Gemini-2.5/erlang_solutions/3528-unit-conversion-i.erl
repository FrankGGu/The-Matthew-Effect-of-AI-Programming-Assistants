-module(solution).
-export([convert/3]).

to_meters(Value, "mm") -> Value * 0.001;
to_meters(Value, "cm") -> Value * 0.01;
to_meters(Value, "m") -> Value;
to_meters(Value, "km") -> Value * 1000.0;
to_meters(Value, "inch") -> Value * 0.0254;
to_meters(Value, "ft") -> Value * 0.3048;
to_meters(Value, "yd") -> Value * 0.9144;
to_meters(Value, "mile") -> Value * 1609.344.

from_meters(ValueInMeters, "mm") -> ValueInMeters / 0.001;
from_meters(ValueInMeters, "cm") -> ValueInMeters / 0.01;
from_meters(ValueInMeters, "m") -> ValueInMeters;
from_meters(ValueInMeters, "km") -> ValueInMeters / 1000.0;
from_meters(ValueInMeters, "inch") -> ValueInMeters / 0.0254;
from_meters(ValueInMeters, "ft") -> ValueInMeters / 0.3048;
from_meters(ValueInMeters, "yd") -> ValueInMeters / 0.9144;
from_meters(ValueInMeters, "mile") -> ValueInMeters / 1609.344.

convert(Value, SourceUnit, TargetUnit) ->
    Meters = to_meters(Value, SourceUnit),
    from_meters(Meters, TargetUnit).