package main

func findKthMissingPositive(arr []int, k int) int {
    left, right := 0, len(arr)
    for left < right {
        mid := left + (right-left)/2
        if arr[mid] - mid - 1 < k {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left + k
}