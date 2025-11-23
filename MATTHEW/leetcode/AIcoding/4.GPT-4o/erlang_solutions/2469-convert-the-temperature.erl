-module(solution).
-export([convertTemperature/1]).

convertTemperature(T) ->
    Celsius = list_to_float(T),
    Kelvin = Celsius + 273.15,
    Fahrenheit = Celsius * 9 / 5 + 32,
    io_lib:format("~.2f~n~.2f", [Kelvin, Fahrenheit]).