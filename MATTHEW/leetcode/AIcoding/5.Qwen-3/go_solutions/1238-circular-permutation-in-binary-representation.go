package main

func circularPermutation(n int, start int) []int {
    result := make([]int, n)
    result[0] = start
    for i := 1; i < n; i++ {
        result[i] = result[i-1] ^ (1 << (i - 1))
    }
    return result
}