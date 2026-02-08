func countAnagrams(s string) int {
    const mod = 1e9 + 7
    words := strings.Fields(s)
    res := 1
    for _, word := range words {
        freq := make(map[rune]int)
        for _, c := range word {
            freq[c]++
        }
        total := 1
        for _, cnt := range freq {
            total = (total * factorial(cnt)) % mod
        }
        perm := factorial(len(word)) * modInv(total, mod) % mod
        res = (res * perm) % mod
    }
    return res
}

func factorial(n int) int {
    const mod = 1e9 + 7
    res := 1
    for i := 2; i <= n; i++ {
        res = (res * i) % mod
    }
    return res
}

func modInv(a, mod int) int {
    return pow(a, mod-2, mod)
}

func pow(a, b, mod int) int {
    res := 1
    for b > 0 {
        if b&1 == 1 {
            res = (res * a) % mod
        }
        a = (a * a) % mod
        b >>= 1
    }
    return res
}