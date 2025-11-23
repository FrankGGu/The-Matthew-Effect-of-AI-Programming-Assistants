package main

func maxXor(arr []int) int {
    maxVal := 0
    for i := 0; i < len(arr); i++ {
        for j := i + 1; j < len(arr); j++ {
            if arr[i]^arr[j] > maxVal {
                maxVal = arr[i] ^ arr[j]
            }
        }
    }
    return maxVal
}