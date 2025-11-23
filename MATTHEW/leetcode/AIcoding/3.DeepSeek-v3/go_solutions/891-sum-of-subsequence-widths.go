func sumSubseqWidths(nums []int) int {
    const mod = 1e9 + 7
    sort.Ints(nums)
    n := len(nums)
    pow2 := make([]int, n)
    pow2[0] = 1
    for i := 1; i < n; i++ {
        pow2[i] = (pow2[i-1] * 2) % mod
    }
    res := 0
    for i := 0; i < n; i++ {
        res = (res + nums[i]*(pow2[i] - pow2[n-1-i])) % mod
    }
    return res
}