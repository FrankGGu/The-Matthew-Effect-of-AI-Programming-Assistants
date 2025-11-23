func longestSubsequenceRepeatedK(s string, k int) string {
    n := len(s)
    freq := make([]int, 26)
    for _, ch := range s {
        freq[ch-'a']++
    }
    possibleChars := []byte{}
    for i := 0; i < 26; i++ {
        if freq[i] >= k {
            possibleChars = append(possibleChars, byte('a'+i))
        }
    }
    var res string
    var dfs func([]byte, string)
    dfs = func(chars []byte, current string) {
        if len(current) > len(res) {
            if isValid(s, current, k) {
                res = current
            }
        }
        if len(current) == len(chars) {
            return
        }
        for i := 0; i < len(chars); i++ {
            if len(current) > 0 && chars[i] <= current[len(current)-1] {
                continue
            }
            dfs(chars, current+string(chars[i]))
        }
    }
    dfs(possibleChars, "")
    return res
}

func isValid(s string, sub string, k int) bool {
    n, m := len(s), len(sub)
    repeat := 0
    j := 0
    for i := 0; i < n; i++ {
        if s[i] == sub[j] {
            j++
            if j == m {
                repeat++
                if repeat == k {
                    return true
                }
                j = 0
            }
        }
    }
    return false
}