package main

func checkSubarraySum(nums []int, k int) bool {
    sumMap := make(map[int]int)
    sumMap[0] = -1
    currentSum := 0
    for i := 0; i < len(nums); i++ {
        currentSum += nums[i]
        if k != 0 {
            currentSum %= k
        }
        if val, ok := sumMap[currentSum]; ok {
            if i-val >= 2 {
                return true
            }
        } else {
            sumMap[currentSum] = i
        }
    }
    return false
}