import "fmt"

func maxScore(nums []int) int {
	n := len(nums)
	memo := make(map[int]int)

	var gcd func(a, b int) int
	gcd = func(a, b int) int {
		if b == 0 {
			return a
		}
		return gcd(b, a%b)
	}

	var solve func(mask int, op int) int
	solve = func(mask int, op int) int {
		if op > n/2 {
			return 0
		}

		if val, ok := memo[mask]; ok {
			return val
		}

		maxScore := 0
		for i := 0; i < n; i++ {
			if (mask & (1 << i)) == 0 {
				for j := i + 1; j < n; j++ {
					if (mask & (1 << j)) == 0 {
						newMask := mask | (1 << i) | (1 << j)
						score := op * gcd(nums[i], nums[j])
						maxScore = max(maxScore, score+solve(newMask, op+1))
					}
				}
				break
			}
		}

		memo[mask] = maxScore
		return maxScore
	}

	return solve(0, 1)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}