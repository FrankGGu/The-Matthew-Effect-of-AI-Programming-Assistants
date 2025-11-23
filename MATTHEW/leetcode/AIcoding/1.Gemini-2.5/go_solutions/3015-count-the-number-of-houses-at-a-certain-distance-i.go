package main

import "math"

func countOfPairs(n int, x int, y int) []int {
	ans := make([]int, n)

	// Ensure u is the smaller house number and v is the larger for the tunnel endpoints.
	u, v := x, y
	if u > v {
		u, v = v, u
	}

	for i := 1; i <= n; i++ {
		for j := i + 1; j <= n; j++ {
			// Calculate distance for three possible paths between house i and house j:

			// Path 1: Direct path along the street
			dist1 := j - i

			// Path 2: Path using the tunnel (i -> u -> v -> j)
			// Distance from i to u, plus 1 for the tunnel, plus distance from v to j
			dist2 := int(math.Abs(float64(i-u))) + 1 + int(math.Abs(float64(j-v)))

			// Path 3: Path using the tunnel (i -> v -> u -> j)
			// Distance from i to v, plus 1 for the tunnel, plus distance from u to j
			dist3 := int(math.Abs(float64(i-v))) + 1 + int(math.Abs(float64(j-u)))

			// The actual minimum distance is the shortest of these three paths
			minDist := int(math.Min(float64(dist1), math.Min(float64(dist2), float64(dist3))))

			// Increment the count for this distance.
			// The problem asks for ans[k] to be the count for distance k+1,
			// so we use minDist - 1 as the index.
			ans[minDist-1]++
		}
	}

	return ans
}