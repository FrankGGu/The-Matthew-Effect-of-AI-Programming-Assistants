package main

func sumOfSubarrays(arr []int) int {
    n := len(arr)
    result := 0
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            for k := i; k <= j; k++ {
                result += arr[k]
            }
        }
    }
    return result
}