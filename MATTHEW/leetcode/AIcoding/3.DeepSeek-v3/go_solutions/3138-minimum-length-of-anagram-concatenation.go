func minAnagramLength(s string) int {
    n := len(s)
    for l := 1; l <= n; l++ {
        if n % l != 0 {
            continue
        }
        freq := make([]int, 26)
        for i := 0; i < l; i++ {
            freq[s[i]-'a']++
        }
        valid := true
        for i := l; i < n; i += l {
            currFreq := make([]int, 26)
            for j := i; j < i+l; j++ {
                currFreq[s[j]-'a']++
            }
            for k := 0; k < 26; k++ {
                if currFreq[k] != freq[k] {
                    valid = false
                    break
                }
            }
            if !valid {
                break
            }
        }
        if valid {
            return l
        }
    }
    return n
}