func minimumSeconds(nums []int) int {
    n := len(nums)
    lastIndex := make(map[int]int)
    maxDistance := 0

    for i := 0; i < n; i++ {
        if lastIdx, exists := lastIndex[nums[i]]; exists {
            distance := (i - lastIdx + n) % n
            maxDistance = max(maxDistance, distance)
        }
        lastIndex[nums[i]] = i
    }

    for _, idx := range lastIndex {
        distance := (n - idx + n) % n
        maxDistance = max(maxDistance, distance)
    }

    return (maxDistance + 1) / 2
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}