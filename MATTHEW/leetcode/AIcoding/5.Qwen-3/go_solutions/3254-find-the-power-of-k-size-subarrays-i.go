package main

func resultsArray(nums []int, k int) []int {
    n := len(nums)
    result := make([]int, 0, n-k+1)
    for i := 0; i <= n-k; i++ {
        maxVal := nums[i]
        for j := i + 1; j < i+k; j++ {
            if nums[j] > maxVal {
                maxVal = nums[j]
            }
        }
        result = append(result, maxVal)
    }
    return result
}