func findValidPair(s string) []string {
    var result []string
    for i := 0; i < len(s)-1; i++ {
        if s[i] == s[i+1] {
            result = append(result, string(s[i])+string(s[i+1]))
        }
    }
    return result
}