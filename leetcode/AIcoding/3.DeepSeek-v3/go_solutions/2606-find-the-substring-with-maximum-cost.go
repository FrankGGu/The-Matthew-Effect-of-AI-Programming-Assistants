func maximumCostSubstring(s string, chars string, vals []int) int {
    cost := make(map[rune]int)
    for i := 0; i < 26; i++ {
        cost[rune('a'+i)] = i + 1
    }
    for i, c := range chars {
        cost[c] = vals[i]
    }

    maxSum := 0
    currentSum := 0
    for _, c := range s {
        currentSum += cost[c]
        if currentSum < 0 {
            currentSum = 0
        }
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }
    return maxSum
}