package main

func countHomogenous(s string) int {
    const MOD = 1000000007
    result := 0
    count := 1
    for i := 1; i < len(s); i++ {
        if s[i] == s[i-1] {
            count++
        } else {
            count = 1
        }
        result = (result + count) % MOD
    }
    return result
}