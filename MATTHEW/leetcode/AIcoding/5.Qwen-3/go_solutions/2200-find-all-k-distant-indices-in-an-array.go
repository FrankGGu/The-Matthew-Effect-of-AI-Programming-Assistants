package main

func getAverages(k int, nums []int) []int {
    n := len(nums)
    result := make([]int, 0, n-k)
    for i := 0; i < n; i++ {
        if i-k >= 0 && i+k < n {
            result = append(result, i)
        }
    }
    return result
}