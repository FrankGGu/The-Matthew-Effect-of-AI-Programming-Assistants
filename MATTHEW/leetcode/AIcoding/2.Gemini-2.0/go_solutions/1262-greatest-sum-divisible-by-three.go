func greatestSumDivisibleByThree(nums []int) int {
	dp := [3]int{0, -1, -1}
	for _, num := range nums {
		rem := num % 3
		newDp := [3]int{}
		for i := 0; i < 3; i++ {
			newDp[i] = dp[i]
		}
		for i := 0; i < 3; i++ {
			if dp[i] != -1 {
				newRem := (i + rem) % 3
				newVal := dp[i] + num
				if newVal > dp[newRem] {
					newDp[newRem] = newVal
				}
			}
		}
		dp = newDp
	}
	return dp[0]
}