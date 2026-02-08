package main

func xorSum(a []int, b []int) int {
    var result int
    for i := 0; i < len(a); i++ {
        for j := 0; j < len(b); j++ {
            result ^= (a[i] & b[j])
        }
    }
    return result
}