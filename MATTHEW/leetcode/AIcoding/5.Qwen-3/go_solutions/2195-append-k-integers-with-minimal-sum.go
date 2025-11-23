package main

func minIntegerArray(nums []int, k int) int {
    for i := 0; i < k; i++ {
        minIndex := i
        for j := i + 1; j < len(nums); j++ {
            if nums[j] < nums[minIndex] {
                minIndex = j
            }
        }
        nums[i], nums[minIndex] = nums[minIndex], nums[i]
    }
    sum := 0
    for _, num := range nums {
        sum += num
    }
    return sum
}