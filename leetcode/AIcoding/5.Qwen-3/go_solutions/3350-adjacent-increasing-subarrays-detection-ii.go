package main

func countSubarrays(arr []int) int {
    n := len(arr)
    res := 0
    for i := 0; i < n; i++ {
        if i+1 < n && arr[i+1] == arr[i]+1 {
            j := i + 1
            for j+1 < n && arr[j+1] == arr[j]+1 {
                j++
            }
            length := j - i + 1
            res += length * (length - 1) / 2
            i = j
        }
    }
    return res
}