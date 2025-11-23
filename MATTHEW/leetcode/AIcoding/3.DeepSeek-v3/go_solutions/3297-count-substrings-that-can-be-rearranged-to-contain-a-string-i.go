func countSubstrings(s string, t string) int {
    count := 0
    for i := 0; i < len(s); i++ {
        for j := i + 1; j <= len(s); j++ {
            sub := s[i:j]
            for k := 0; k <= len(t) - len(sub); k++ {
                target := t[k:k+len(sub)]
                if check(sub, target) {
                    count++
                }
            }
        }
    }
    return count
}

func check(a, b string) bool {
    diff := 0
    for i := 0; i < len(a); i++ {
        if a[i] != b[i] {
            diff++
            if diff > 1 {
                return false
            }
        }
    }
    return diff == 1
}