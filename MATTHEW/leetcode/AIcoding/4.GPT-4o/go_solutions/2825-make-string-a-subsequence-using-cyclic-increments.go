func canMakeSubsequence(s1 string, s2 string) bool {
    n, m := len(s1), len(s2)
    if m > n {
        return false
    }

    j := 0
    for i := 0; i < n; i++ {
        if j < m && (s1[i]-'a' == s2[j]-'a' || (s1[i]-'a'+1)%26 == s2[j]-'a') || (s1[i]-'a'+25)%26 == s2[j]-'a') {
            j++
        }
    }
    return j == m
}