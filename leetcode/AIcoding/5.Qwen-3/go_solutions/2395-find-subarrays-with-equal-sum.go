package main

func findSubarraysWithEqualSum(nums []int) bool {
    n := len(nums)
    sumMap := make(map[int]bool)
    for i := 0; i < n-1; i++ {
        currentSum := nums[i] + nums[i+1]
        if sumMap[currentSum] {
            return true
        }
        sumMap[currentSum] = true
    }
    return false
}