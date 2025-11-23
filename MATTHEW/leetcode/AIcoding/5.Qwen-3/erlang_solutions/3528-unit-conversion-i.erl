-module(unit_conversion_i).
-export([convert/2]).

convert(Value, FromUnit) ->
    convert(Value, FromUnit, 1).

convert(Value, "m", ToUnit) when ToUnit == "cm" -> Value * 100;
convert(Value, "m", ToUnit) when ToUnit == "mm" -> Value * 1000;
convert(Value, "cm", ToUnit) when ToUnit == "m" -> Value / 100;
convert(Value, "cm", ToUnit) when ToUnit == "mm" -> Value * 10;
convert(Value, "mm", ToUnit) when ToUnit == "m" -> Value / 1000;
convert(Value, "mm", ToUnit) when ToUnit == "cm" -> Value / 10;
convert(Value, FromUnit, FromUnit) -> Value.