func minPairRemovals(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    pairs := 0
    for _, c := range count {
        pairs += c / 2
    }

    return len(nums) - 2*pairs
}