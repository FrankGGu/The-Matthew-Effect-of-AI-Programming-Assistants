import (
	"math"
	"sort"
)

func minimumIncompatibility(nums []int, k int) int {
	n := len(nums)
	groupSize := n / k
	dp := make([]int, 1<<n)
	for i := range dp {
		dp[i] = -1
	}
	dp[0] = 0

	var solve func(mask int) int
	solve = func(mask int) int {
		if dp[mask] != -1 {
			return dp[mask]
		}

		if mask == (1<<n)-1 {
			return 0
		}

		best := math.MaxInt32
		available := []int{}
		for i := 0; i < n; i++ {
			if (mask & (1 << i)) == 0 {
				available = append(available, i)
			}
		}

		var backtrack func(index int, currentMask int, currentGroup []int)
		backtrack = func(index int, currentMask int, currentGroup []int) {
			if len(currentGroup) == groupSize {
				sort.Ints(currentGroup)
				incompatibility := nums[currentGroup[groupSize-1]] - nums[currentGroup[0]]
				seen := make(map[int]bool)
				valid := true
				for _, idx := range currentGroup {
					if seen[nums[idx]] {
						valid = false
						break
					}
					seen[nums[idx]] = true
				}
				if valid {
					nextMask := mask | currentMask
					nextRes := solve(nextMask)
					if nextRes != -1 {
						best = min(best, incompatibility+nextRes)
					}
				}
				return
			}

			if index == len(available) {
				return
			}

			backtrack(index+1, currentMask|(1<<available[index]), append(currentGroup, available[index]))
			backtrack(index+1, currentMask, currentGroup)
		}

		backtrack(0, 0, []int{})

		if best == math.MaxInt32 {
			dp[mask] = -1
		} else {
			dp[mask] = best
		}
		return dp[mask]
	}

	return solve(0)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}