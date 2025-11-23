func minPairRemovals(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    maxFreq := 0
    for _, freq := range count {
        if freq > maxFreq {
            maxFreq = freq
        }
    }

    return len(nums) - maxFreq
}