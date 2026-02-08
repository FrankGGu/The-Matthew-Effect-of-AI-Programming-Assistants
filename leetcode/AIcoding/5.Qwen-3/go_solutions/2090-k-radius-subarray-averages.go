package main

func resultsArray(nums []int, k int) []int {
    n := len(nums)
    result := make([]int, n)
    for i := 0; i < n; i++ {
        result[i] = -1
    }
    for i := k; i < n-k; i++ {
        valid := true
        for j := 1; j <= k; j++ {
            if nums[i-j] > nums[i-j+1] {
                valid = false
                break
            }
        }
        if valid {
            result[i] = nums[i]
        }
    }
    return result
}