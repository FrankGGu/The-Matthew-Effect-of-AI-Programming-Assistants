func maximumSum(arr []int) int {
	n := len(arr)
	dp0 := make([]int, n)
	dp1 := make([]int, n)
	dp0[0] = arr[0]
	dp1[0] = 0
	ans := arr[0]
	for i := 1; i < n; i++ {
		dp0[i] = max(arr[i], dp0[i-1]+arr[i])
		dp1[i] = max(dp0[i-1], dp1[i-1]+arr[i])
		ans = max(ans, max(dp0[i], dp1[i]))
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}