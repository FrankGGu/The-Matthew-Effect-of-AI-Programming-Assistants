import "fmt"

func maximumANDSum(nums []int, numSlots int) int {
	n := len(nums)
	slots := numSlots
	dp := make([]int, 1<<(slots*2))

	var solve func(idx int, mask int) int
	solve = func(idx int, mask int) int {
		if idx == n {
			return 0
		}

		if dp[mask] != 0 {
			return dp[mask]
		}

		maxSum := 0
		for i := 0; i < slots; i++ {
			if (mask & (1 << (i * 2))) == 0 {
				newMask := mask | (1 << (i * 2))
				currentSum := (nums[idx] & (i + 1)) + solve(idx+1, newMask)
				if currentSum > maxSum {
					maxSum = currentSum
				}
			} else if (mask & (1 << (i*2 + 1))) == 0 {
				newMask := mask | (1 << (i*2 + 1))
				currentSum := (nums[idx] & (i + 1)) + solve(idx+1, newMask)
				if currentSum > maxSum {
					maxSum = currentSum
				}
			}
		}

		dp[mask] = maxSum
		return maxSum
	}

	return solve(0, 0)
}