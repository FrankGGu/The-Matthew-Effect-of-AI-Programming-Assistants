package main

func matrixSum(nums [][]int) int {
    for i := 0; i < len(nums); i++ {
        sort.Ints(nums[i])
    }
    res := 0
    for j := 0; j < len(nums[0]); j++ {
        maxVal := 0
        for i := 0; i < len(nums); i++ {
            if nums[i][j] > maxVal {
                maxVal = nums[i][j]
            }
        }
        res += maxVal
    }
    return res
}