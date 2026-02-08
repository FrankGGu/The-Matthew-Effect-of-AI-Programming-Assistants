package main

func substrHash(s string, power int, modulo int, k int, i int) int {
    n := len(s)
    hash := 0
    for j := 0; j < k; j++ {
        hash = (hash*power + int(s[i+j])) % modulo
    }
    return hash
}

func getLucky(s string) int {
    res := 0
    for _, c := range s {
        res = res*10 + int(c-'a'+1)
    }
    return res
}

func findSubstring(s string, power int, modulo int, k int, target int) string {
    n := len(s)
    if k > n {
        return ""
    }
    targetHash := target
    currentHash := 0
    for i := 0; i < k; i++ {
        currentHash = (currentHash*power + int(s[i])) % modulo
    }
    if currentHash == targetHash {
        return s[0:k]
    }
    powerK := 1
    for i := 0; i < k; i++ {
        powerK = (powerK * power) % modulo
    }
    for i := 1; i <= n-k; i++ {
        currentHash = (currentHash - int(s[i-1])*powerK) % modulo
        if currentHash < 0 {
            currentHash += modulo
        }
        currentHash = (currentHash*power + int(s[i+k-1])) % modulo
        if currentHash == targetHash {
            return s[i : i+k]
        }
    }
    return ""
}