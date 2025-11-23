package main

func numOfSubarrays(arr []int) int {
    mod := 1000000007
    even, odd := 0, 0
    res := 0
    for _, num := range arr {
        if num%2 == 0 {
            even++
        } else {
            even, odd = odd, even+1
        }
        res = (res + odd) % mod
    }
    return res
}