func subStrHash(s string, power int, mod int, k int, hashValue int) string {
    n := len(s)
    currentHash := 0
    powerK := 1

    for i := 0; i < k; i++ {
        currentHash = (currentHash*power + int(s[i]-'a'+1)) % mod
        if i < k-1 {
            powerK = (powerK * power) % mod
        }
    }

    if currentHash == hashValue {
        return s[:k]
    }

    for i := k; i < n; i++ {
        currentHash = (currentHash*power + int(s[i]-'a'+1)) % mod
        currentHash = (currentHash - (int(s[i-k]-'a'+1) * powerK) % mod + mod) % mod
        if currentHash == hashValue {
            return s[i-k+1 : i+1]
        }
    }

    return ""
}