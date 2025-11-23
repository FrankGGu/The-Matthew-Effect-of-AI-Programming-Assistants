package main

func minPairSum(nums []int) int {
    sort.Ints(nums)
    max := 0
    for i := 0; i < len(nums)/2; i++ {
        sum := nums[i] + nums[len(nums)-1-i]
        if sum > max {
            max = sum
        }
    }
    return max
}