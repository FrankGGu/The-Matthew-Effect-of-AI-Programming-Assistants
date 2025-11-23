package main

func findEncryptedData(nums []int, k int) []int {
    n := len(nums)
    result := make([]int, n)
    for i := 0; i < n; i++ {
        result[i] = nums[(i + k) % n]
    }
    return result
}