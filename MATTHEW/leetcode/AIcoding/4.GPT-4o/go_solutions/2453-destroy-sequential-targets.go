func destroyTargets(nums []int, space int) int {
    count := make(map[int]int)
    maxCount := 0
    result := 0

    for _, num := range nums {
        remainder := num % space
        count[remainder]++
        if count[remainder] > maxCount {
            maxCount = count[remainder]
            result = num
        } else if count[remainder] == maxCount {
            result = min(result, num)
        }
    }

    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}