package main

func numberOfSubarrays(nums []int, k int) int {
    count := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        andVal := nums[i]
        if andVal == k {
            count++
        }
        for j := i + 1; j < n; j++ {
            andVal &= nums[j]
            if andVal == k {
                count++
            }
        }
    }
    return count
}