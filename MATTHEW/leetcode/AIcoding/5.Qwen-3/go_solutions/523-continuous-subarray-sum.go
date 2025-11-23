package main

func hasContinuousSubarraySum(nums []int, k int) bool {
    if len(nums) < 2 {
        return false
    }
    prefixSum := 0
    sumMap := make(map[int]bool)
    sumMap[0] = true
    for i := 0; i < len(nums); i++ {
        prefixSum += nums[i]
        mod := prefixSum % k
        if mod == 0 {
            return true
        }
        if sumMap[mod] {
            return true
        }
        sumMap[mod] = true
    }
    return false
}