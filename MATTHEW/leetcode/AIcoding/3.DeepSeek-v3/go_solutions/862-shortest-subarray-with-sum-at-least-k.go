func shortestSubarray(nums []int, k int) int {
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }

    deque := make([]int, 0)
    res := n + 1

    for i := 0; i <= n; i++ {
        for len(deque) > 0 && prefix[i] - prefix[deque[0]] >= k {
            res = min(res, i - deque[0])
            deque = deque[1:]
        }
        for len(deque) > 0 && prefix[i] <= prefix[deque[len(deque)-1]] {
            deque = deque[:len(deque)-1]
        }
        deque = append(deque, i)
    }

    if res <= n {
        return res
    }
    return -1
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}