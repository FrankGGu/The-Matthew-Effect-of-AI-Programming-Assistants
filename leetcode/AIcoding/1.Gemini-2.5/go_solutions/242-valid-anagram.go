func isAnagram(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }

    counts := [26]int{}

    for i := 0; i < len(s); i++ {
        counts[s[i]-'a']++
        counts[t[i]-'a']--
    }

    for i := 0; i < 26; i++ {
        if counts[i] != 0 {
            return false
        }
    }

    return true
}