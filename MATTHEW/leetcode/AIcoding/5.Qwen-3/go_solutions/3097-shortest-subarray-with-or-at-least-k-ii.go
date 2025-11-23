package main

func shortestSubarray(nums []int, k int) int {
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] | nums[i]
    }

    minLen := n + 1
    dq := []int{}

    for i := 0; i <= n; i++ {
        for len(dq) > 0 && prefix[i] <= prefix[dq[len(dq)-1]] {
            dq = dq[:len(dq)-1]
        }

        for len(dq) > 0 && prefix[i]-prefix[dq[0]] >= k {
            minLen = min(minLen, i-dq[0])
            dq = dq[1:]
        }

        dq = append(dq, i)
    }

    if minLen <= n {
        return minLen
    }
    return -1
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}