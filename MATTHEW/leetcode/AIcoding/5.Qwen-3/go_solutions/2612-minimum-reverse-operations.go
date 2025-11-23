package main

func minReverseOperations(nums []int, k int) int {
    n := len(nums)
    if k == 1 {
        return 0
    }
    if k == n {
        return 0
    }

    dist := make([]int, n)
    for i := range dist {
        dist[i] = -1
    }

    queue := []int{}
    for i := 0; i < n; i++ {
        if nums[i] == 0 {
            dist[i] = 0
            queue = append(queue, i)
            break
        }
    }

    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        for v := max(0, u-k+1); v <= min(n-1, u+k-1); v++ {
            if dist[v] == -1 {
                dist[v] = dist[u] + 1
                queue = append(queue, v)
            }
        }
    }

    result := -1
    for i := 0; i < n; i++ {
        if nums[i] == 0 {
            result = dist[i]
            break
        }
    }

    return result
}