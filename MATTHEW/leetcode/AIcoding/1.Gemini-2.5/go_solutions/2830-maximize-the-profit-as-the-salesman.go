package main

import (
	"sort"
)

func maximizeTheProfit(n int, offers [][]int) int {
	sort.Slice(offers, func(i, j int) bool {
		if offers[i][1] != offers[j][1] {
			return offers[i][1] < offers[j][1]
		}
		return offers[i][0] < offers[j][0]
	})

	numOffers := len(offers)
	dp := make([]int, numOffers+1)

	for i := 1; i <= numOffers; i++ {
		currentOffer := offers[i-1]
		currentStart := currentOffer[0]
		currentProfit := currentOffer[2]

		dp[i] = dp[i-1]

		idx := sort.Search(i-1, func(k int) bool {
			return offers[k][1] >= currentStart
		})

		profitIfTaken := currentProfit
		if idx > 0 {
			profitIfTaken += dp[idx]
		}

		dp[i] = max(dp[i], profitIfTaken)
	}

	return dp[numOffers]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}