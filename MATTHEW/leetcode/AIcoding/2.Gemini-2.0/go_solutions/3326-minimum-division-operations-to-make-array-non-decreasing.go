import (
	"math"
)

func minimumDivisionOperations(nums []int, divisors []int) int {
	n := len(nums)
	m := len(divisors)

	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, 1<<m)
		for j := range dp[i] {
			dp[i][j] = math.MaxInt32
		}
	}

	for mask := 0; mask < (1 << m); mask++ {
		newNum := nums[0]
		ops := 0
		for i := 0; i < m; i++ {
			if (mask>>i)&1 == 1 {
				if divisors[i] != 0 && newNum%divisors[i] == 0 {
					newNum /= divisors[i]
					ops++
				} else {
					ops = math.MaxInt32
					break
				}
			}
		}

		dp[0][mask] = ops
	}

	for i := 1; i < n; i++ {
		for mask := 0; mask < (1 << m); mask++ {
			newNum := nums[i]
			ops := 0
			for j := 0; j < m; j++ {
				if (mask>>j)&1 == 1 {
					if divisors[j] != 0 && newNum%divisors[j] == 0 {
						newNum /= divisors[j]
						ops++
					} else {
						ops = math.MaxInt32
						break
					}
				}
			}
			if ops == math.MaxInt32 {
				continue
			}

			for prevMask := 0; prevMask < (1 << m); prevMask++ {
				prevNum := nums[i-1]
				for j := 0; j < m; j++ {
					if (prevMask>>j)&1 == 1 {
						if divisors[j] != 0 && prevNum%divisors[j] == 0{
							prevNum /= divisors[j]
						} else {
							prevNum = math.MinInt32
							break
						}
					}
				}
				if prevNum == math.MinInt32 {
					continue
				}

				if newNum >= prevNum {
					dp[i][mask] = min(dp[i][mask], dp[i-1][prevMask]+ops)
				}
			}
		}
	}

	ans := math.MaxInt32
	for mask := 0; mask < (1 << m); mask++ {
		ans = min(ans, dp[n-1][mask])
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}