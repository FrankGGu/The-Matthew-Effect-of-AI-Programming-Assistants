func findLHS(nums []int) int {
    count := make(map[int]int)
    maxLen := 0

    for _, num := range nums {
        count[num]++
    }

    for num, c := range count {
        if _, exists := count[num+1]; exists {
            maxLen = max(maxLen, c+count[num+1])
        }
    }

    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}