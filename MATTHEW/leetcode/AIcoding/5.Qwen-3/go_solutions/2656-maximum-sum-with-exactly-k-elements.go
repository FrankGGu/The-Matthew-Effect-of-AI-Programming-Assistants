package main

func maxSum(ints []int, k int) int {
    sort.Ints(ints)
    sum := 0
    for i := len(ints) - 1; i >= len(ints)-k; i-- {
        sum += ints[i]
    }
    return sum
}