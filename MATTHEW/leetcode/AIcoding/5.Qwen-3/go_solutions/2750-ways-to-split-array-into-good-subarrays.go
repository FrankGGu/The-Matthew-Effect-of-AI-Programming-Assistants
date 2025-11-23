package main

func numSubarraysWithOnlyOnes(arr []int) int {
    const MOD = 1000000007
    count := 0
    res := 0
    for i := 0; i < len(arr); i++ {
        if arr[i] == 1 {
            count++
        } else {
            count = 0
        }
        res = (res + count) % MOD
    }
    return res
}