func kSimilarity(s1 string, s2 string) int {
    if s1 == s2 {
        return 0
    }

    n := len(s1)
    queue := []string{s1}
    visited := make(map[string]bool)
    visited[s1] = true