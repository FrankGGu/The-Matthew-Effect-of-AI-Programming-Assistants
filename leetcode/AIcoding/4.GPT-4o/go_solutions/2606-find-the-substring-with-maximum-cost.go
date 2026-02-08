func maximumCostSubstring(s string, cost []int, chars string) int {
    charCost := make(map[rune]int)
    for i, c := range chars {
        charCost[c] = cost[i]
    }

    maxCost := 0
    currentCost := 0

    for _, c := range s {
        if val, exists := charCost[c]; exists {
            currentCost += val
        } else {
            currentCost = 0
        }
        if currentCost > maxCost {
            maxCost = currentCost
        }
    }

    return maxCost
}