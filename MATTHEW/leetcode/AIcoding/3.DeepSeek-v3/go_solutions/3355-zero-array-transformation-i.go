func minimumOperations(nums []int) int {
    freq := make(map[int]bool)
    for _, num := range nums {
        if num > 0 {
            freq[num] = true
        }
    }
    return len(freq)
}