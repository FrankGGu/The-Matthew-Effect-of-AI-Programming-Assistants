package main

func largestSumAfterKNegations(nums []int, k int) int {
    for i := 0; i < k; i++ {
        minIndex := 0
        for j := 1; j < len(nums); j++ {
            if nums[j] < nums[minIndex] {
                minIndex = j
            }
        }
        nums[minIndex] *= -1
    }
    sum := 0
    for _, num := range nums {
        sum += num
    }
    return sum
}