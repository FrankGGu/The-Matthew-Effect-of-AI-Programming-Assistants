package main

func countTriplets(arr []int) int {
    n := len(arr)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] ^ arr[i]
    }
    res := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if prefix[i] == prefix[j] {
                res += (j - i)
            }
        }
    }
    return res
}