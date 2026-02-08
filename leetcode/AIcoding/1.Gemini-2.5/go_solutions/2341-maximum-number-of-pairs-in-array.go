func numberOfPairs(nums []int) []int {
    freq := [1001]int{}
    for _, num := range nums {
        freq[num]++
    }

    pairs := 0
    leftovers := 0

    for _, count := range freq {
        pairs += count / 2
        leftovers += count % 2
    }

    return []int{pairs, leftovers}
}