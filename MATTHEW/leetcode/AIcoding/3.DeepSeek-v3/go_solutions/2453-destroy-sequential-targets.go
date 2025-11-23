func destroyTargets(nums []int, space int) int {
    freq := make(map[int]int)
    maxFreq := 0

    for _, num := range nums {
        mod := num % space
        freq[mod]++
        if freq[mod] > maxFreq {
            maxFreq = freq[mod]
        }
    }

    minNum := math.MaxInt32
    for _, num := range nums {
        mod := num % space
        if freq[mod] == maxFreq && num < minNum {
            minNum = num
        }
    }

    return minNum
}