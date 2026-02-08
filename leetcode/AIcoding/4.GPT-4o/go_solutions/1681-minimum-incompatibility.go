import "math"

func minimumIncompatibility(nums []int, k int) int {
	n := len(nums)
	maxNum := 0
	for _, num := range nums {
		if num > maxNum {
			maxNum = num
		}
	}

	groupSize := n / k
	if n%k != 0 {
		return -1
	}

	mask := 1 << n
	dp := make([]int, mask)
	for i := range dp {
		dp[i] = math.MaxInt32
	}
	dp[0] = 0

	for i := 0; i < mask; i++ {
		count := 0
		used := make(map[int]bool)
		for j := 0; j < n; j++ {
			if (i>>j)&1 == 1 {
				count++
				used[nums[j]] = true
			}
		}
		if count > groupSize {
			continue
		}
		if count == groupSize {
			incompatibility := 0
			for num := range used {
				incompatibility++
			}
			nextMask := i
			for j := 0; j < n; j++ {
				if (i>>j)&1 == 0 {
					nextMask |= (1 << j)
				}
			}
			dp[nextMask] = min(dp[nextMask], dp[i]+incompatibility)
		}
	}

	return dp[mask-1] == math.MaxInt32 ? -1 : dp[mask-1]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}