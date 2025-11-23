package main

func minSum(nums []int, k int) int {
    n := len(nums)
    for i := 0; i < k; i++ {
        maxIndex := 0
        for j := 1; j < n; j++ {
            if nums[j] > nums[maxIndex] {
                maxIndex = j
            }
        }
        nums[maxIndex]--
    }
    sum := 0
    for _, num := range nums {
        sum += num
    }
    return sum
}