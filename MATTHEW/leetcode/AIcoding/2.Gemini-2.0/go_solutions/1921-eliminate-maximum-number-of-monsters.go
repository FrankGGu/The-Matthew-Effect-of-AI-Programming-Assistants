import "sort"

func eliminateMaximum(dist []int, speed []int) int {
	n := len(dist)
	arrivalTimes := make([]float64, n)
	for i := 0; i < n; i++ {
		arrivalTimes[i] = float64(dist[i]) / float64(speed[i])
	}
	sort.Float64s(arrivalTimes)
	count := 0
	for i := 0; i < n; i++ {
		if arrivalTimes[i] <= float64(i) {
			break
		}
		count++
	}
	return count
}