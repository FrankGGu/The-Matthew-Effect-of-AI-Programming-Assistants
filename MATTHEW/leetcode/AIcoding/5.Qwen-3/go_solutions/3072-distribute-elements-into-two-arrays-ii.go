package main

func distributeElements(arr []int) []int {
    a := make([]int, 0)
    b := make([]int, 0)
    for _, num := range arr {
        if len(a) <= len(b) {
            a = append(a, num)
        } else {
            b = append(b, num)
        }
    }
    return append(a, b...)
}