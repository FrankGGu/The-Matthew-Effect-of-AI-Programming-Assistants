-module(unit_conversion).
-export([convert/4]).

convert(Value, FromUnit, ToUnit, ConversionData) ->
    case FromUnit =:= ToUnit of
        true -> Value;
        false ->
            case lists:keyfind({FromUnit, ToUnit}, 1, ConversionData) of
                {{FromUnit, ToUnit}, Factor} -> Value * Factor;
                false ->
                    case lists:keyfind({ToUnit, FromUnit}, 1, ConversionData) of
                        {{ToUnit, FromUnit}, Factor} -> Value / Factor;
                        false -> error
                    end
            end
    end.