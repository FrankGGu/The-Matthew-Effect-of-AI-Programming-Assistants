package main

func beautifulPairs(nums []int, k int) int {
    count := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if (nums[i]+nums[j])%k == 0 {
                count++
            }
        }
    }
    return count
}