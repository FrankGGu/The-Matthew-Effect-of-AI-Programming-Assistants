import "sort"

func maximizeTheProfit(n int, offers [][]int) int {
	sort.Slice(offers, func(i, j int) bool {
		return offers[i][1] < offers[j][1]
	})

	dp := make([]int, len(offers)+1)
	for i := 1; i <= len(offers); i++ {
		dp[i] = dp[i-1]
		currentOffer := offers[i-1]
		profit := currentOffer[2]
		prevIndex := findPrev(offers, currentOffer[0], i-1)
		if prevIndex == -1 {
			dp[i] = max(dp[i], profit)
		} else {
			dp[i] = max(dp[i], dp[prevIndex+1]+profit)
		}
	}

	return dp[len(offers)]
}

func findPrev(offers [][]int, end int, index int) int {
	left, right := 0, index-1
	ans := -1
	for left <= right {
		mid := left + (right-left)/2
		if offers[mid][1] <= end {
			ans = mid
			left = mid + 1
		} else {
			right = mid - 1
		}
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}