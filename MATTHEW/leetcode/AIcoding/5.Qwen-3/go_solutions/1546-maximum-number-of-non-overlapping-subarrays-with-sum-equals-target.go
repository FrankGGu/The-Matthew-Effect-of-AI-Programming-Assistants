package main

func maxNumberSubarraysWithSum(nums []int, target int) int {
    sumMap := make(map[int]int)
    sumMap[0] = -1
    currentSum := 0
    count := 0
    for i := 0; i < len(nums); i++ {
        currentSum += nums[i]
        if prevIndex, found := sumMap[currentSum-target]; found {
            count++
            sumMap = make(map[int]int)
            sumMap[0] = i
            currentSum = 0
        } else {
            sumMap[currentSum] = i
        }
    }
    return count
}