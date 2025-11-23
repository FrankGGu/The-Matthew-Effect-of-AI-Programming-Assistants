func findJudge(n int, trust [][]int) int {
    if n == 1 && len(trust) == 0 {
        return 1
    }

    trustCount := make([]int, n+1)

    for _, t := range trust {
        trustCount[t[1]]++
        trustCount[t[0]]--
    }

    for i := 1; i <= n; i++ {
        if trustCount[i] == n-1 {
            return i
        }
    }

    return -1
}