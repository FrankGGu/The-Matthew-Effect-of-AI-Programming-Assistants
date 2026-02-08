-module(temperature).
-export([convert_temperature/1]).

convert_temperature(celsius) ->
  kelvin = celsius + 273.15,
  fahrenheit = celsius * 1.80 + 32.00,
  [kelvin, fahrenheit].