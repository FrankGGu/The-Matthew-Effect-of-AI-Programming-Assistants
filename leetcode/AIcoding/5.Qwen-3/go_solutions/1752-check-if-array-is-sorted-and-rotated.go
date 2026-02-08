package main

func check(nums []int) bool {
    n := len(nums)
    count := 0
    for i := 1; i < n; i++ {
        if nums[i-1] > nums[i] {
            count++
            if count > 1 {
                return false
            }
        }
    }
    if nums[n-1] > nums[0] {
        count++
    }
    return count <= 1
}