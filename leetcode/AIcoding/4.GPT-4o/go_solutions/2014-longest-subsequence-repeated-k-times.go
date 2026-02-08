func longestSubsequenceRepeatedK(s string, k int) string {
    count := make(map[byte]int)
    for i := 0; i < len(s); i++ {
        count[s[i]]++
    }

    var res []byte
    for i := 0; i < len(s); i++ {
        if count[s[i]] >= k {
            res = append(res, s[i])
            count[s[i]] = 0
        }
    }

    longest := ""
    for i := 0; i < len(res); i++ {
        subseq := ""
        for j := i; j < len(res); j++ {
            subseq += string(res[j])
            if isValid(subseq, s, k) && len(subseq) > len(longest) {
                longest = subseq
            }
        }
    }
    return longest
}

func isValid(subseq, s string, k int) bool {
    count := 0
    for i := 0; i <= len(s)-len(subseq); i++ {
        if s[i:i+len(subseq)] == subseq {
            count++
        }
        if count >= k {
            return true
        }
    }
    return false
}