package main

func isPossible(n int, queries []int) bool {
    arr := make([]int, n)
    for _, q := range queries {
        if q < 0 || q >= n {
            continue
        }
        for i := q; i < n; i += q + 1 {
            arr[i]++
        }
    }
    for _, v := range arr {
        if v == 0 {
            return false
        }
    }
    return true
}