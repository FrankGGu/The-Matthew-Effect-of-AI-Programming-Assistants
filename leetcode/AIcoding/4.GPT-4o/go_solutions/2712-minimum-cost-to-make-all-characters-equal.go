func minimumCost(s string) int {
    count := make([]int, 26)
    for _, char := range s {
        count[char-'a']++
    }

    minCost := len(s)
    for _, c := range count {
        if c > 0 {
            cost := len(s) - c
            if cost < minCost {
                minCost = cost
            }
        }
    }

    return minCost
}