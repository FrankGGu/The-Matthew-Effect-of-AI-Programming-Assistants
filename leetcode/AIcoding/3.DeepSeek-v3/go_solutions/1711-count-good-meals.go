func countPairs(deliciousness []int) int {
    mod := int(1e9 + 7)
    maxVal := 0
    for _, d := range deliciousness {
        if d > maxVal {
            maxVal = d
        }
    }
    maxSum := 2 * maxVal
    count := 0
    freq := make(map[int]int)

    for _, num := range deliciousness {
        for sum := 1; sum <= maxSum; sum <<= 1 {
            if val, exists := freq[sum - num]; exists {
                count = (count + val) % mod
            }
        }
        freq[num]++
    }
    return count
}