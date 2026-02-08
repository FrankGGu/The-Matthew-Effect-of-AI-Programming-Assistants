package main

func findArray(pref []int) []int {
    n := len(pref)
    res := make([]int, n)
    res[0] = pref[0]
    for i := 1; i < n; i++ {
        res[i] = pref[i] ^ pref[i-1]
    }
    return res
}