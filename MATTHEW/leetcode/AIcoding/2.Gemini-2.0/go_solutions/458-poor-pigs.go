import "math"

func poorPigs(buckets int, minutesToDie int, minutesToTest int) int {
	if buckets == 1 {
		return 0
	}
	tests := minutesToTest / minutesToDie
	pigs := 0
	for math.Pow(float64(tests+1), float64(pigs)) < float64(buckets) {
		pigs++
	}
	return pigs
}