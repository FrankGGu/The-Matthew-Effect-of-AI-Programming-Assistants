func subStrHash(s string, power int, modulo int, k int, hashValue int) string {
    n := len(s)
    if n < k {
        return ""
    }

    var h, powerK int64
    powerK = 1
    h = 0
    mod := int64(modulo)
    p := int64(power)

    for i := n - k; i < n; i++ {
        h = (h * p + int64(s[i] - 'a' + 1)) % mod
        if i != n - k {
            powerK = (powerK * p) % mod
        }
    }

    res := -1
    if int(h) == hashValue {
        res = n - k
    }

    for i := n - k - 1; i >= 0; i-- {
        h = (h - int64(s[i + k] - 'a' + 1) * powerK % mod + mod) % mod
        h = (h * p + int64(s[i] - 'a' + 1)) % mod
        if int(h) == hashValue {
            res = i
        }
    }

    if res == -1 {
        return ""
    }
    return s[res : res + k]
}