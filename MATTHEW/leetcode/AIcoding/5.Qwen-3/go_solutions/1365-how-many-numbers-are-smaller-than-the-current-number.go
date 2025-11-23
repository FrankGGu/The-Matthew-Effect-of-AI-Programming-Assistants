package main

func smallerNumbersThanCurrent(nums []int) []int {
    result := make([]int, len(nums))
    for i := 0; i < len(nums); i++ {
        count := 0
        for j := 0; j < len(nums); j++ {
            if nums[j] < nums[i] {
                count++
            }
        }
        result[i] = count
    }
    return result
}