package main

func countSubseqSum(s []int, target int) int {
    mod := 1000000007
    freq := make(map[int]int)
    freq[0] = 1
    res := 0
    sum := 0
    for _, num := range s {
        sum += num
        res = (res + freq[sum-target]) % mod
        freq[sum] = (freq[sum] + 1) % mod
    }
    return res
}