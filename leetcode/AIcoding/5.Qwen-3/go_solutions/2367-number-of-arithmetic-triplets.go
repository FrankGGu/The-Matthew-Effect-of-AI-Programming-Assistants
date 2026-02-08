package main

func arithmeticTriplets(nums []int, target int) int {
    count := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            for k := j + 1; k < n; k++ {
                if nums[j]-nums[i] == nums[k]-nums[j] && nums[i]+nums[j]+nums[k] == target {
                    count++
                }
            }
        }
    }
    return count
}