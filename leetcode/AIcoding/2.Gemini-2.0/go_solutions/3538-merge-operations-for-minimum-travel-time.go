import (
	"math"
	"sort"
)

func getMinTravelTime(locations []int) float64 {
	sort.Ints(locations)
	n := len(locations)
	if n <= 1 {
		return 0.0
	}

	dp := make([][]float64, n)
	for i := range dp {
		dp[i] = make([]float64, n)
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			dp[i][j] = math.MaxFloat64
			for k := i; k < j; k++ {
				dp[i][j] = math.Min(dp[i][j], dp[i][k]+dp[k+1][j]+float64(locations[j]-locations[i]))
			}
		}
	}

	return dp[0][n-1]
}