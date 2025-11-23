package main

func largestPerimeter(nums []int) int {
    sort.Ints(nums)
    for i := len(nums) - 1; i >= 2; i-- {
        a, b, c := nums[i-2], nums[i-1], nums[i]
        if a+b > c {
            return a + b + c
        }
    }
    return -1
}