package main

func minPairRemovalToSort(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return 0
    }

    res := 0
    i := 0
    for i < n-1 {
        if nums[i] > nums[i+1] {
            res++
            i += 2
        } else {
            i++
        }
    }
    return res
}