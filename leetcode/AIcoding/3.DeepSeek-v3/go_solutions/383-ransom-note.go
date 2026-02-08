func canConstruct(ransomNote string, magazine string) bool {
    count := make([]int, 26)
    for _, c := range magazine {
        count[c-'a']++
    }
    for _, c := range ransomNote {
        count[c-'a']--
        if count[c-'a'] < 0 {
            return false
        }
    }
    return true
}