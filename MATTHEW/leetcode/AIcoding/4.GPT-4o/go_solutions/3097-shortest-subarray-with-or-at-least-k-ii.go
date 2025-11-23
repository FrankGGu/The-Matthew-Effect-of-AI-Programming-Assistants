func shortestSubarray(A []int, K int) int {
    n := len(A)
    prefix := make([]int, n+1)
    for i := 1; i <= n; i++ {
        prefix[i] = prefix[i-1] | A[i-1]
    }

    ans := n + 1
    for i := 0; i < n; i++ {
        for j := i + 1; j <= n; j++ {
            if prefix[j] | prefix[i] >= K {
                ans = min(ans, j-i)
            }
        }
    }

    if ans == n+1 {
        return -1
    }
    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}