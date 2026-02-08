package main

func findDuplicates(nums []int) []int {
    result := make([]int, 0)
    for _, num := range nums {
        index := abs(num) - 1
        if nums[index] < 0 {
            result = append(result, abs(num))
        } else {
            nums[index] *= -1
        }
    }
    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}