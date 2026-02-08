func countPalindromicSubseq(s string) int {
    n := len(s)
    uniquePalindromes := make(map[string]struct{})

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if s[i] == s[j] {
                for k := 0; k < n; k++ {
                    if k != i && k != j && s[k] == s[i] {
                        uniquePalindromes[string([]rune{s[i], s[k], s[j]})] = struct{}{}
                    }
                }
            }
        }
    }

    return len(uniquePalindromes)
}