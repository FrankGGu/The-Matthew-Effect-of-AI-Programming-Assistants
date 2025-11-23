func minLength(s string) int {
    n := len(s)

    for k := 1; k <= n; k++ {
        if n%k == 0 {
            baseFreq := getFreq(s[0:k])
            isValidK := true
            for i := 1; i < n/k; i++ {
                chunkFreq := getFreq(s[i*k : (i+1)*k])
                if baseFreq != chunkFreq {
                    isValidK = false
                    break
                }
            }
            if isValidK {
                return k
            }
        }
    }
    return n
}

func getFreq(sub string) [26]int {
    var freq [26]int
    for _, r := range sub {
        freq[r-'a']++
    }
    return freq
}