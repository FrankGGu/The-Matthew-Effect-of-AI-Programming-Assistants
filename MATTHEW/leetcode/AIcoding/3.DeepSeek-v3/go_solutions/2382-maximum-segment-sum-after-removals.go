func maximumSegmentSum(nums []int, removeQueries []int) []int64 {
    n := len(nums)
    parent := make([]int, n)
    sum := make([]int64, n)
    for i := range parent {
        parent[i] = i
        sum[i] = int64(nums[i])
    }

    var find func(int) int
    find = func(u int) int {
        if parent[u] != u {
            parent[u] = find(parent[u])
        }
        return parent[u]
    }

    union := func(u, v int) {
        pu, pv := find(u), find(v)
        if pu != pv {
            parent[pv] = pu
            sum[pu] += sum[pv]
        }
    }

    res := make([]int64, len(removeQueries))
    removed := make([]bool, n)
    maxSum := int64(0)

    for i := len(removeQueries) - 1; i >= 0; i-- {
        res[i] = maxSum
        pos := removeQueries[i]
        removed[pos] = true
        currentSum := int64(nums[pos])

        if pos > 0 && removed[pos-1] {
            currentSum += sum[find(pos-1)]
            union(pos, pos-1)
        }
        if pos < n-1 && removed[pos+1] {
            currentSum += sum[find(pos+1)]
            union(pos, pos+1)
        }

        sum[find(pos)] = currentSum
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }

    return res
}