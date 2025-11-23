package main

func maximumElementAfterDecreasing(arr []int) int {
    sort.Ints(arr)
    arr[len(arr)-1] = 1
    for i := len(arr) - 2; i >= 0; i-- {
        if arr[i] > arr[i+1]-1 {
            arr[i] = arr[i+1] - 1
        }
    }
    return arr[0]
}