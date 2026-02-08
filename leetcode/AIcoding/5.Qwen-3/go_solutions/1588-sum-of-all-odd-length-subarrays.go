package main

func sumOddLengthSubarrays(arr []int) int {
    result := 0
    n := len(arr)
    for i := 0; i < n; i++ {
        count := 0
        for j := i; j < n; j++ {
            count++
            if count%2 == 1 {
                for k := i; k <= j; k++ {
                    result += arr[k]
                }
            }
        }
    }
    return result
}