func changeDataType(arr []int) []float64 {
	result := make([]float64, len(arr))
	for i, num := range arr {
		result[i] = float64(num)
	}
	return result
}