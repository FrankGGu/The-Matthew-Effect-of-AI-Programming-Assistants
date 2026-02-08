package main

func peaks(arr []int) []int {
    var result []int
    for i := 1; i < len(arr)-1; i++ {
        if arr[i] > arr[i-1] && arr[i] > arr[i+1] {
            result = append(result, i)
        }
    }
    return result
}