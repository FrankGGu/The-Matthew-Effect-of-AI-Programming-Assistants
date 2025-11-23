package main

func maximumSum(arr []int, k int) int {
    if k == 0 {
        return 0
    }
    sort.Ints(arr)
    sum := 0
    for i := len(arr) - 1; i >= len(arr)-k; i-- {
        sum += arr[i]
    }
    return sum
}