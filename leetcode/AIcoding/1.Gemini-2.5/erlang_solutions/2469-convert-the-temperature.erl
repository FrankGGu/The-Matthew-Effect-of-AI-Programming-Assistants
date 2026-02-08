-module(solution).
-export([convertTemperature/1]).

convertTemperature(Celsius) ->
    Kelvin = Celsius + 273.15,
    Fahrenheit = Celsius * 1.80 + 32.00,
    [Kelvin, Fahrenheit].