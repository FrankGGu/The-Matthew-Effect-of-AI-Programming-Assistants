package main

func numberOfArithmeticSlices(nums []int) int {
    n := len(nums)
    if n < 3 {
        return 0
    }
    count := 0
    for i := 0; i < n-2; i++ {
        diff := nums[i+1] - nums[i]
        j := i + 2
        for j < n && nums[j]-nums[j-1] == diff {
            count++
            j++
        }
    }
    return count
}