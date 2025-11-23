func closestCost(baseCosts []int, toppingCosts []int, target int) int {
    closest := -1
    minDiff := math.MaxInt32

    var dfs func(int, int) 
    dfs = func(i int, currentCost int) {
        if i == len(toppingCosts) {
            diff := abs(currentCost - target)
            if diff < minDiff || (diff == minDiff && (closest == -1 || currentCost < closest)) {
                minDiff = diff
                closest = currentCost
            }
            return
        }
        dfs(i + 1, currentCost) // skip current topping
        dfs(i + 1, currentCost + toppingCosts[i]) // add one of the current topping
        dfs(i + 1, currentCost + 2 * toppingCosts[i]) // add two of the current topping
    }

    for _, base := range baseCosts {
        dfs(0, base)
    }

    return closest
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}