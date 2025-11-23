func maximumSize(nums []int) int {
    count := make(map[int]int)
    maxSize := 0

    for _, num := range nums {
        count[num]++
        if count[num] > 1 {
            for k := range count {
                if count[k] > 1 {
                    count[k]--
                    break
                }
            }
        }
        maxSize = max(maxSize, len(count))
    }

    return maxSize
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}