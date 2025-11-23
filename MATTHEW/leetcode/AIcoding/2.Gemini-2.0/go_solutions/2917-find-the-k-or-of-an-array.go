func findKOr(nums []int, k int) int {
    ans := 0
    for i := 0; i < 31; i++ {
        count := 0
        for _, num := range nums {
            if (num >> i) & 1 == 1 {
                count++
            }
        }
        if count >= k {
            ans |= (1 << i)
        }
    }
    return ans
}