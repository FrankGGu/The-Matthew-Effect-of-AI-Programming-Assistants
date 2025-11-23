package main

func minimumOperations(nums []int) int {
    operations := 0
    for len(nums) > 0 {
        newNums := make([]int, 0)
        for _, num := range nums {
            if num != 0 {
                newNums = append(newNums, num-1)
            }
        }
        if len(newNums) == 0 {
            break
        }
        nums = newNums
        operations++
    }
    return operations
}