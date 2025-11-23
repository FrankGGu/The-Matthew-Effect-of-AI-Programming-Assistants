func shortestUncommonSubstring(A []string) string {
    n := len(A)
    minLen := math.MaxInt64
    result := ""

    for i := 0; i < n; i++ {
        for j := 0; j < len(A[i]); j++ {
            for l := 1; l <= len(A[i])-j; l++ {
                sub := A[i][j : j+l]
                uncommon := true

                for k := 0; k < n; k++ {
                    if k != i && strings.Contains(A[k], sub) {
                        uncommon = false
                        break
                    }
                }

                if uncommon && l < minLen {
                    minLen = l
                    result = sub
                }
            }
        }
    }

    return result
}