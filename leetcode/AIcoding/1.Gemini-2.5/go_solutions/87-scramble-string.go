func isScramble(s1 string, s2 string) bool {
    n := len(s1)
    if n != len(s2) {
        return false
    }
    if n == 0 {
        return true
    }

    // memo[i1][i2][length] stores:
    // 0: uncomputed
    // 1: true
    // -1: false
    memo := make([][][]int, n)
    for i := range memo {
        memo[i] = make([][]int, n)
        for j := range memo[i] {
            memo[i][j] = make([]int, n+1)
        }
    }

    var solve func(i1, i2, length int) int
    solve = func(i1, i2, length int) int {
        if memo[i1][i2][length] != 0 {
            return memo[i1][i2][length]
        }

        // Base case: length 1
        if length == 1 {
            if s1[i1] == s2[i2] {
                memo[i1][i2][length] = 1
                return 1
            } else {
                memo[i1][i2][length] = -1
                return -1
            }
        }

        // Recursive step
        for p := 1; p < length; p++ { // p is the length of the first part
            // Case 1: No swap
            // s1[i1...i1+p-1] vs s2[i2...i2+p-1]
            // s1[i1+p...i1+length-1] vs s2[i2+p...i2+length-1]
            if solve(i1, i2, p) == 1 && solve(i1+p, i2+p, length-p) == 1 {
                memo[i1][i2][length] = 1
                return 1
            }

            // Case 2: Swap
            // s1[i1...i1+p-1] vs s2[i2+length-p...i2+length-1]
            // s1[i1+p...i1+length-1] vs s2[i2...i2+length-p-1]
            if solve(i1, i2+length-p, p) == 1 && solve(i1+p, i2, length-p) == 1 {
                memo[i1][i2][length] = 1
                return 1
            }
        }

        memo[i1][i2][length] = -1
        return -1
    }

    result := solve(0, 0, n)
    return result == 1
}