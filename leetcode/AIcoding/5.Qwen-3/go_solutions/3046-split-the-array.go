package main

func isSplitPossible(nums []int) bool {
    sum := 0
    for _, num := range nums {
        sum += num
    }
    leftSum := 0
    for i := 0; i < len(nums)-1; i++ {
        leftSum += nums[i]
        rightSum := sum - leftSum
        if leftSum%3 == 0 && rightSum%3 == 0 {
            return true
        }
    }
    return false
}