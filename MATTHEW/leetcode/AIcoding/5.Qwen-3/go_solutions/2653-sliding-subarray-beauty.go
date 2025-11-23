package main

func sumOfSubarrayBeauties(nums []int, k int) int {
    const MOD = 1000000007
    count := make([]int, 101)
    for i := 0; i < k; i++ {
        count[nums[i]]++
    }
    res := 0
    for i := k; i <= len(nums); i++ {
        if i < len(nums) {
            count[nums[i-k]]--
            count[nums[i]]++
        }
        for j := 1; j <= 100; j++ {
            if count[j] > 0 {
                res = (res + j) % MOD
                break
            }
        }
    }
    return res
}