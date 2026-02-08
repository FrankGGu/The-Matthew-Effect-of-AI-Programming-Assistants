func convertUnit(value float64, unit1 string, unit2 string) float64 {
    conversions := map[string]float64{
        "inch": 0.0254,
        "foot": 0.3048,
        "yard": 0.9144,
        "mile": 1609.344,
        "mm":   0.001,
        "cm":   0.01,
        "m":    1.0,
        "km":   1000.0,
        "g":    0.001,
        "kg":   1.0,
        "lb":   0.453592,
        "oz":   0.0283495,
        "l":    0.001,
        "ml":   0.000001,
    }

    return value * conversions[unit1] / conversions[unit2]
}