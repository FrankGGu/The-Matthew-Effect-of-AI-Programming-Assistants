func comfortableHumidity(humidities []int, lower int, upper int) int {
	count := 0
	for _, h := range humidities {
		if h >= lower && h <= upper {
			count++
		}
	}
	return count
}