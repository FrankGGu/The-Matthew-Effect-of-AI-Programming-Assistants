func maximumBeauty(flowers []int, day: int) int {
    sort.Ints(flowers)
    n := len(flowers)
    maxBeauty := 0
    totalFlowers := 0

    for i := 0; i < n && flowers[i] <= day; i++ {
        totalFlowers += flowers[i]
        maxBeauty = max(maxBeauty, totalFlowers+(day-flowers[i])*(i+1))
    }

    return maxBeauty
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}