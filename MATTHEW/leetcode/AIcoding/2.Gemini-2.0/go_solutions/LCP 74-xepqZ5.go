import "sort"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxStrength(nums []int, r int) int {
	n := len(nums)
	points := make([][]int, n)
	for i := 0; i < n; i++ {
		points[i] = []int{nums[i], i}
	}
	sort.Slice(points, func(i, j int) bool {
		return points[i][0] < points[j][0]
	})

	dp := make([]int, n)
	dp[0] = points[0][0]

	for i := 1; i < n; i++ {
		dp[i] = points[i][0]
		for j := 0; j < i; j++ {
			if abs(points[i][1]-points[j][1]) <= r {
				dp[i] = max(dp[i], dp[j]+points[i][0])
			}
		}
	}

	ans := 0
	for i := 0; i < n; i++ {
		ans = max(ans, dp[i])
	}
	return ans
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}