func distinctEchoSubstrings(text string) int {
    n := len(text)
    seen := make(map[string]bool)

    for length := 1; length <= n/2; length++ {
        for i := 0; i <= n-2*length; i++ {
            j := i + length
            if text[i:j] == text[j:j+length] {
                seen[text[i:j+length]] = true
            }
        }
    }

    return len(seen)
}