package main

func maxNumberOfGroups(arr []int) int {
    sort.Ints(arr)
    count := 0
    for i := 0; i < len(arr); i++ {
        if arr[i] > count {
            count++
        }
    }
    return count
}