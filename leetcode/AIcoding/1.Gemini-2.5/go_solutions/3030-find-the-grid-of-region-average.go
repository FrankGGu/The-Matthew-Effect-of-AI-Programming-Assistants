import "math"

func regionAverage(image [][]int, threshold int) [][]int {
	m := len(image)
	n := len(image[0])

	result := make([][]int, m)
	for i := range result {
		result[i] = make([]int, n)
		copy(