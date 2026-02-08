func maximumSegmentSum(nums []int, removeQueries []int) []int64 {
    n := len(nums)
    parent := make([]int, n)
    size := make([]int64, n)
    for i := 0; i < n; i++ {
        parent[i] = i
        size[i] = 0
    }

    find := func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    union := func(x, y int) {
        rootX := find(x)
        rootY := find(y)
        if rootX != rootY {
            if size[rootX] < size[rootY] {
                rootX, rootY = rootY, rootX
            }
            parent[rootY] = rootX
            size[rootX] += size[rootY]
        }
    }

    answer := make([]int64, n)
    totalSum := int64(0)
    active := make([]bool, n)

    for i, query := range removeQueries {
        active[query] = true
        totalSum += int64(nums[query])
        size[query] = int64(nums[query])

        if query > 0 && active[query-1] {
            union(query, query-1)
        }
        if query < n-1 && active[query+1] {
            union(query, query+1)
        }

        maxSum := int64(0)
        for j := 0; j < n; j++ {
            if active[j] {
                root := find(j)
                maxSum = max(maxSum, size[root])
            }
        }

        answer[i] = maxSum
    }

    return answer
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}