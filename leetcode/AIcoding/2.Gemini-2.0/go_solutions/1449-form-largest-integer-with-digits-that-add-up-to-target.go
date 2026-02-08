import (
	"sort"
	"strconv"
)

func largestNumber(cost []int, target int) string {
	dp := make([]string, target+1)
	for i := 1; i <= target; i++ {
		dp[i] = "0"
	}

	for i := 0; i < 9; i++ {
		c := cost[i]
		digit := strconv.Itoa(i + 1)
		for j := c; j <= target; j++ {
			if dp[j-c] != "0" || j == c {
				newNum := ""
				if dp[j-c] == "0" {
					newNum = digit
				} else {
					newNum = dp[j-c] + digit
				}
				if len(newNum) > len(dp[j]) {
					dp[j] = newNum
				} else if len(newNum) == len(dp[j]) && newNum > dp[j] {
					dp[j] = newNum
				}
			}
		}
	}

	if dp[target] == "0" {
		return "0"
	}

	sort.Slice( []rune(dp[target]), func(i, j int) bool{
		return []rune(dp[target])[i] > []rune(dp[target])[j]
	})

	return dp[target]
}