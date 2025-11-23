package main

func findTheArrayConcCatQuery(nums []int, k int) int {
    n := len(nums)
    res := 0
    for i := 0; i < n; i++ {
        if i > 0 && nums[i] < nums[i-1] {
            return -1
        }
        res = (res * 10 + nums[i]) % k
    }
    return res
}