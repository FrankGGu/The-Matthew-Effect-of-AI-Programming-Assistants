-module(convert_the_temperature).
-export([convert/2]).

convert(T, unit) ->
    case unit of
        celsius -> [T * 1.8 + 32.0, T + 273.15];
        fahrenheit -> [(T - 32.0) / 1.8, (T - 32.0) / 1.8 + 273.15];
        kelvin -> [T - 273.15, (T - 273.15) * 1.8 + 32.0]
    end.