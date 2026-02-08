package main

func maxSumAfterOperations(nums []int, ops [][]int) int {
    n := len(nums)
    for _, op := range ops {
        a, b := op[0], op[1]
        for i := a; i <= b; i++ {
            nums[i] = nums[i] * nums[i]
        }
    }
    sum := 0
    for _, num := range nums {
        sum += num
    }
    return sum
}