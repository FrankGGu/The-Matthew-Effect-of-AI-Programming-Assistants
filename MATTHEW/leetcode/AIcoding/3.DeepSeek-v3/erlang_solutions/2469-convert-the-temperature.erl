-spec convert_temperature(Celsius :: float()) -> [float()].
convert_temperature(Celsius) ->
    Kelvin = Celsius + 273.15,
    Fahrenheit = Celsius * 1.80 + 32.00,
    [Kelvin, Fahrenheit].