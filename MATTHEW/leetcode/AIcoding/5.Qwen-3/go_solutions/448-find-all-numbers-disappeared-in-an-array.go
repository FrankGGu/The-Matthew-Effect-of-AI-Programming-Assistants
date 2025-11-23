package main

func findDisappearedNumbers(nums []int) []int {
    for _, num := range nums {
        index := abs(num) - 1
        if nums[index] > 0 {
            nums[index] = -nums[index]
        }
    }

    result := make([]int, 0)
    for i := 0; i < len(nums); i++ {
        if nums[i] > 0 {
            result = append(result, i+1)
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