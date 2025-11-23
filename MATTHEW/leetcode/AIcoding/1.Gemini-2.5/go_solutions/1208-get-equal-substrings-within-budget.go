func equalSubstring(s string, t string, maxCost int) int {
    n := len(s)
    left := 0
    currentCost := 0
    maxLength := 0

    for right := 0; right < n; right++ {
        cost := abs(int(s[right]) - int(t[right]))
        currentCost += cost

        for currentCost > maxCost {
            currentCost -= abs(int(s[left]) - int(t[left]))
            left++
        }
        maxLength = max(maxLength, right-left+1)
    }
    return maxLength
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}