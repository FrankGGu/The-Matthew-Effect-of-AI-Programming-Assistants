func convertTemperature(celsius float64) []float64 {
    fahrenheit := celsius*1.8 + 32
    kelvin := celsius + 273.15
    return []float64{fahrenheit, kelvin}
}