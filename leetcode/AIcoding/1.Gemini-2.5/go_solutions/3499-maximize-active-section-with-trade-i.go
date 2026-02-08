import "math"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximumSum(arr []int) int {
	n := len(arr)
	if n == 0 {
		return 0
	}
	if n == 1 {
		return arr[0]
	}

	fw := make([]int, n)
	bw := make([]int, n)

	fw[0] = arr[0]
	maxSoFar := arr[0]
	for i := 1; i < n; i++ {
		fw[i] = max(arr[i], fw[i-1]+arr[i])
		maxSoFar = max(maxSoFar, fw[i])
	}

	bw[n-1] = arr[n-1]
	for i := n - 2; i >= 0; i-- {
		bw[i] = max(arr[i], bw[i+1]+arr[i])
	}

	ans := maxSoFar

	for i := 0; i < n; i++ {
		if i > 0 && i < n-1 {
			ans = max(ans, fw[i-1]+bw[i+1])
		} else if i == 0 && n > 1 {
			ans = max(ans, bw[1])
		} else if i == n-1 && n > 1 {
			ans = max(ans, fw[n-2])
		}
	}

	return ans
}