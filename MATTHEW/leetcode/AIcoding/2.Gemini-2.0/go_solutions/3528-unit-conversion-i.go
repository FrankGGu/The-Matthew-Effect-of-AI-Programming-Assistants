func Convert(value float64, fromUnit string, toUnit string) float64 {
	var meters float64
	switch fromUnit {
	case "cm":
		meters = value / 100
	case "m":
		meters = value
	case "km":
		meters = value * 1000
	case "inch":
		meters = value * 0.0254
	case "ft":
		meters = value * 0.3048
	case "yd":
		meters = value * 0.9144
	case "mi":
		meters = value * 1609.34
	}

	var result float64
	switch toUnit {
	case "cm":
		result = meters * 100
	case "m":
		result = meters
	case "km":
		result = meters / 1000
	case "inch":
		result = meters / 0.0254
	case "ft":
		result = meters / 0.3048
	case "yd":
		result = meters / 0.9144
	case "mi":
		result = meters / 1609.34
	}
	return result
}