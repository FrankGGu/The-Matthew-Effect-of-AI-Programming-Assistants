func numberOfPairs(nums []int) []int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    pairs := 0
    leftover := 0
    for _, count := range freq {
        pairs += count / 2
        leftover += count % 2
    }
    return []int{pairs, leftover}
}