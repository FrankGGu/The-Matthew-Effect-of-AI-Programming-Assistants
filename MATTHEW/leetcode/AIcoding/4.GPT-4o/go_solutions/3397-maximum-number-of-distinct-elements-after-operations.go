func maximumDistinctElements(nums []int) int {
    frequency := make(map[int]int)
    for _, num := range nums {
        frequency[num]++
    }

    distinctCount := len(frequency)
    used := make(map[int]bool)

    for _, num := range nums {
        if frequency[num] > 1 {
            frequency[num]--
            if !used[num] {
                distinctCount++
                used[num] = true
            }
        }
    }

    return distinctCount
}