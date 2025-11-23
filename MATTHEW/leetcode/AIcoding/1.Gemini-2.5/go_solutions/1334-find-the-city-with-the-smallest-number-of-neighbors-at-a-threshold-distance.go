import "math"

func findTheCity(n int, edges [][]int, distanceThreshold int) int {
	const infinity = math.MaxInt32 / 2 // Use a large enough value to represent infinity

	// Initialize distance matrix
	dist := make([][]int, n)
	for i := range dist {
		dist[i]