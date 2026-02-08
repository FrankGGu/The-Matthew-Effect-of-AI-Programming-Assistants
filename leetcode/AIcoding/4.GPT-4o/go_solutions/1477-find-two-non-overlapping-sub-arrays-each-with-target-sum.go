func minSumOfLengths(arr []int, target int) int {
	n := len(arr)
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + arr[i]
	}

	minLength := make([]int, n+1)
	for i := 1; i <= n; i++ {
		minLength[i] = n + 1
	}

	res := n + 1
	for i := 0; i < n; i++ {
		for j := i + 1; j <= n; j++ {
			if prefixSum[j]-prefixSum[i] == target {
				length := j - i
				if length < minLength[j] {
					minLength[j] = length
				}
			}
		}
		for j := i + 1; j <= n; j++ {
			if minLength[j] < n+1 {
				res = min(res, (j-i)+minLength[j])
			}
		}
	}

	if res == n+1 {
		return -1
	}
	return res
}