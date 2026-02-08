func minOrAfterOperations(nums []int, k int) int {
    res := 0
    for bit := 29; bit >= 0; bit-- {
        mask := 1 << bit
        res |= mask
        cnt := 0
        current := 0x7fffffff
        for _, num := range nums {
            current &= num
            if (current & res) != res {
                cnt++
                current = 0x7fffffff
            }
        }
        if cnt > k {
            res ^= mask
        }
    }
    return res
}