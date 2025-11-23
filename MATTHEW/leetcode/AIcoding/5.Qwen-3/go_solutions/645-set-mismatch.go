package main

func findErrorNums(nums []int) []int {
    n := len(nums)
    result := make([]int, 2)
    for i := 0; i < n; i++ {
        index := abs(nums[i]) - 1
        if nums[index] < 0 {
            result[0] = abs(nums[i])
        } else {
            nums[index] *= -1
        }
    }
    for i := 0; i < n; i++ {
        if nums[i] > 0 {
            result[1] = i + 1
            break
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