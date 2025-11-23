func divideArray(nums []int) bool {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    for _, count := range freq {
        if count % 2 != 0 {
            return false
        }
    }
    return true
}