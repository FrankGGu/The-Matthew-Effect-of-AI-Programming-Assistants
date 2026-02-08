package main

func sumSubseqWidths(nums []int) int {
    sort.Ints(nums)
    n := len(nums)
    mod := 1000000007
    pow2 := make([]int, n)
    pow2[0] = 1
    for i := 1; i < n; i++ {
        pow2[i] = (pow2[i-1] * 2) % mod
    }
    res := 0
    for i := 0; i < n; i++ {
        res = (res + nums[i]*(pow2[i]-1) - nums[i]*(pow2[n-i-1]-1)) % mod
    }
    return res
}