func shortestSubarray(A []int, K int) int {
    n := len(A)
    prefixSum := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefixSum[i+1] = prefixSum[i] + A[i]
    }

    deque := []int{}
    minLength := n + 1

    for i := 0; i <= n; i++ {
        for len(deque) > 0 && prefixSum[i] - prefixSum[deque[0]] >= K {
            minLength = min(minLength, i - deque[0])
            deque = deque[1:]
        }

        for len(deque) > 0 && prefixSum[i] <= prefixSum[deque[len(deque)-1]] {
            deque = deque[:len(deque)-1]
        }

        deque = append(deque, i)
    }

    if minLength > n {
        return -1
    }
    return minLength
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}