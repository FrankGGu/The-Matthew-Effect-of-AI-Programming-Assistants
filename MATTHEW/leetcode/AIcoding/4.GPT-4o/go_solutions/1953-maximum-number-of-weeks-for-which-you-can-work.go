func longestAlternatingSubarray(nums []int) int {
    maxWeeks := 0
    total := 0
    for _, num := range nums {
        if num == 0 {
            total = 0
        } else {
            total++
            maxWeeks = max(maxWeeks, total)
        }
    }
    return maxWeeks
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}