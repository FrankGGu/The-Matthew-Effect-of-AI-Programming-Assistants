package main

func sumImbalanceNumbers(nums []int) int {
    n := len(nums)
    res := 0
    for i := 0; i < n; i++ {
        maxVal := nums[i]
        minVal := nums[i]
        used := make(map[int]bool)
        used[nums[i]] = true
        for j := i + 1; j < n; j++ {
            if used[nums[j]] {
                continue
            }
            used[nums[j]] = true
            if nums[j] > maxVal {
                maxVal = nums[j]
            }
            if nums[j] < minVal {
                minVal = nums[j]
            }
            res += maxVal - minVal
        }
    }
    return res
}