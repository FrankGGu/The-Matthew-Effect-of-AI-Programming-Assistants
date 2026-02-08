import "fmt"

func lastStoneWeightII(stones []int) int {
	sum := 0
	for _, s := range stones {
		sum += s
	}
	target := sum / 2
	dp := make([]bool, target+1)
	dp[0] = true
	for _, stone := range stones {
		for j := target; j >= stone; j-- {
			dp[j] = dp[j] || dp[j-stone]
		}
	}
	for j := target; j >= 0; j-- {
		if dp[j] {
			return sum - 2*j
		}
	}
	return 0
}