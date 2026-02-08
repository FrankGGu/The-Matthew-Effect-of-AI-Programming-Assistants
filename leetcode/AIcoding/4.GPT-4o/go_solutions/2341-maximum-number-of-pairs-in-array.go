func numberOfPairs(nums []int) []int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    pairs := 0
    leftovers := 0

    for _, c := range count {
        pairs += c / 2
        leftovers += c % 2
    }

    return []int{pairs, leftovers}
}