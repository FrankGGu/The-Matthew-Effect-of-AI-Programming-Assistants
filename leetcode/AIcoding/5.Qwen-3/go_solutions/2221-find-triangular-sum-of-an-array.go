package main

func triangularSum(nums []int) int {
    n := len(nums)
    for i := 0; i < n-1; i++ {
        for j := 0; j < n-1-i; j++ {
            nums[j] = (nums[j] + nums[j+1]) % 1000000007
        }
    }
    return nums[0]
}