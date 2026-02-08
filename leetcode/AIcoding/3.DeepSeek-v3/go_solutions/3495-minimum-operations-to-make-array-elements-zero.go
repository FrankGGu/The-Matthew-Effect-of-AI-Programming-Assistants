func minOperations(nums []int) int {
    res := 0
    maxLen := 0
    for _, num := range nums {
        bits := 0
        for num > 0 {
            res += num & 1
            num >>= 1
            bits++
        }
        if bits > maxLen {
            maxLen = bits
        }
    }
    return res + maxLen - 1
}