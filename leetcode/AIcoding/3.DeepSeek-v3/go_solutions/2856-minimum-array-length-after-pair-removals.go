func minLengthAfterRemovals(nums []int) int {
    n := len(nums)
    freq := make(map[int]int)
    maxFreq := 0
    for _, num := range nums {
        freq[num]++
        if freq[num] > maxFreq {
            maxFreq = freq[num]
        }
    }
    if maxFreq <= n/2 {
        return n % 2
    }
    return 2*maxFreq - n
}