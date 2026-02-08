func shortestSubarray(A []int, K int) int {
    n := len(A)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] | A[i]
    }

    ans := n + 1
    deque := []int{}

    for i := 0; i <= n; i++ {
        for len(deque) > 0 && prefix[deque[len(deque)-1]] <= prefix[i] {
            deque = deque[:len(deque)-1]
        }

        for len(deque) > 0 && prefix[i] | prefix[deque[0]] >= K {
            ans = min(ans, i-deque[0])
            deque = deque[1:]
        }

        deque = append(deque, i)
    }

    if ans == n + 1 {
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