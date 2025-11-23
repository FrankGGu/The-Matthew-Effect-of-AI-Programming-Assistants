func countSubstrings(s string, t string) int {
    m, n := len(s), len(t)
    ans := 0

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            diff := 0
            for k := 0; k < 26; k++ {
                if (s[i]-'a' == byte(k) && k == int(t[j]-'a')) || (t[j]-'a' == byte(k) && k == int(s[i]-'a')) {
                    continue
                }
                if s[i] == byte(k+'a') {
                    diff++
                }
                if t[j] == byte(k+'a') {
                    diff--
                }
            }
            if diff == 1 {
                ans++
            }
        }
    }

    return ans
}