package main

func numberOfWeeks(arr []int) int {
    sort.Ints(arr)
    res := 0
    for i := len(arr) - 1; i >= 0; i-- {
        if res < arr[i] {
            res++
        } else {
            return res
        }
    }
    return res
}