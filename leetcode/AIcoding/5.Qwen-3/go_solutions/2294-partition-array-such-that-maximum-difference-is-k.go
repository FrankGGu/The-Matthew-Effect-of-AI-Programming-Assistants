package main

func partitionArray(nums []int, k int) bool {
    sort.Ints(nums)
    for i := 0; i < len(nums)-1; i++ {
        if nums[i+1]-nums[i] > k {
            return false
        }
    }
    return true
}