package main

func maxScore(a []int, b []int) int {
    mod := 1000000007
    i, j := 0, 0
    sumA, sumB := 0, 0
    for i < len(a) && j < len(b) {
        if a[i] < b[j] {
            sumA += a[i]
            i++
        } else if a[i] > b[j] {
            sumB += b[j]
            j++
        } else {
            sumA += a[i]
            sumB += b[j]
            i++
            j++
        }
    }
    for i < len(a) {
        sumA += a[i]
        i++
    }
    for j < len(b) {
        sumB += b[j]
        j++
    }
    if sumA > sumB {
        return sumA % mod
    }
    return sumB % mod
}