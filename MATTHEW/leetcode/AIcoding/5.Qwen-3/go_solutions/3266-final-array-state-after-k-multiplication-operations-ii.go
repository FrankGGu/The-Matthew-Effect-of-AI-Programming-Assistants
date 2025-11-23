package main

func getFinalState(nums []int, k int, multiplier int) []int {
    for i := 0; i < k; i++ {
        minIndex := 0
        for j := 1; j < len(nums); j++ {
            if nums[j] < nums[minIndex] {
                minIndex = j
            }
        }
        nums[minIndex] *= multiplier
    }
    return nums
}