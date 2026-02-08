import "math"

func minSumOfLengths(arr []int, target int) int {
	n := len(arr)
	left := make([]int, n)
	right := make([]int, n)

	for i := range left {
		left[i] = math.MaxInt32
		right[i] = math.MaxInt32
	}

	sum := 0
	start := 0
	minLen := math.MaxInt32
	for i := 0; i < n; i++ {
		sum += arr[i]
		for sum > target {
			sum -= arr[start]
			start++
		}
		if sum == target {
			minLen = min(minLen, i-start+1)
		}
		left[i] = minLen
		if i > 0 {
			left[i] = min(left[i], left[i-1])
		}
	}

	sum = 0
	start = n - 1
	minLen = math.MaxInt32
	for i := n - 1; i >= 0; i-- {
		sum += arr[i]
		for sum > target {
			sum -= arr[start]
			start--
		}
		if sum == target {
			minLen = min(minLen, start-i+1)
		}
		right[i] = minLen
		if i < n-1 {
			right[i] = min(right[i], right[i+1])
		}
	}

	ans := math.MaxInt32
	for i := 0; i < n-1; i++ {
		if left[i] != math.MaxInt32 && right[i+1] != math.MaxInt32 {
			ans = min(ans, left[i]+right[i+1])
		}
	}

	if ans == math.MaxInt32 {
		return -1
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}