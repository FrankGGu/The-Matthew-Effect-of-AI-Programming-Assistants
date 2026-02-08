package main

func kDivisibleElementsSubarrays(nums []int, k int) int {
    n := len(nums)
    count := 0
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            if (nums[j]-nums[i])%k == 0 {
                count++
            }
        }
    }
    return count
}