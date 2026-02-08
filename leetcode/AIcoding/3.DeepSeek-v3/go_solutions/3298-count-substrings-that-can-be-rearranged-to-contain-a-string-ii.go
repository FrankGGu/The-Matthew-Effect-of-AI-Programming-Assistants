func countSubstrings(s string, t string) int {
    m, n := len(s), len(t)
    res := 0

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            diff := 0
            for k := 0; i+k < m && j+k < n; k++ {
                if s[i+k] != t[j+k] {
                    diff++
                }
                if diff > 1 {
                    break
                }
                if diff == 1 {
                    res++
                }
            }
        }
    }

    return res
}