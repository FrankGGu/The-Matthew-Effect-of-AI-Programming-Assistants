package main

func minEdgeSumAfterQueries(nums []int, queries []int) []int {
    n := len(nums)
    parent := make([]int, n)
    size := make([]int, n)
    for i := range parent {
        parent[i] = i
        size[i] = 1
    }

    var find func(int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    var union func(int, int)
    union = func(x, y int) {
        rootX := find(x)
        rootY := find(y)
        if rootX == rootY {
            return
        }
        if size[rootX] < size[rootY] {
            rootX, rootY = rootY, rootX
        }
        parent[rootY] = rootX
        size[rootX] += size[rootY]
    }

    for i := 0; i < n-1; i++ {
        union(i, i+1)
    }

    sumMap := make(map[int]int)
    for i := 0; i < n; i++ {
        root := find(i)
        sumMap[root] += nums[i]
    }

    res := make([]int, len(queries))
    for i, q := range queries {
        sum := 0
        for _, v := range sumMap {
            sum += v
        }
        minSum := sum
        for root := range sumMap {
            currentSum := sumMap[root]
            if currentSum < minSum {
                minSum = currentSum
            }
        }
        res[i] = minSum
        for root := range sumMap {
            sumMap[root] -= q
        }
    }

    return res
}