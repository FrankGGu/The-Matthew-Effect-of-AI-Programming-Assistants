import (
	"math"
)

func closestCost(baseCosts []int, toppingCosts []int, target int) int {
	minDiff := math.MaxInt32
	closest := 0

	var dfs func(int, int)
	dfs = func(idx int, currentCost int) {
		diff := abs(currentCost - target)
		if diff < minDiff {
			minDiff = diff
			closest = currentCost
		} else if diff == minDiff && currentCost < closest {
			closest = currentCost
		}

		if idx == len(toppingCosts) {
			return
		}

		dfs(idx+1, currentCost)
		dfs(idx+1, currentCost+toppingCosts[idx])
		dfs(idx+1, currentCost+2*toppingCosts[idx])
	}

	for _, baseCost := range baseCosts {
		dfs(0, baseCost)
	}

	return closest
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}