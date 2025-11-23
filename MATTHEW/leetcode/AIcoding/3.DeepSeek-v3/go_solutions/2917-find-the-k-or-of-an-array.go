func findKOr(nums []int, k int) int {
    res := 0
    for i := 0; i < 32; i++ {
        cnt := 0
        mask := 1 << i
        for _, num := range nums {
            if num & mask != 0 {
                cnt++
            }
        }
        if cnt >= k {
            res |= mask
        }
    }
    return res
}