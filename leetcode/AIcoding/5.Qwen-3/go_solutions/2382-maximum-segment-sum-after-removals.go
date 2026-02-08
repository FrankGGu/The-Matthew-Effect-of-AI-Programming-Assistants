package main

func maximumSegmentSum(nums []int, remove []int) int64 {
    parent := make([]int, len(nums))
    size := make([]int, len(nums))
    sum := make([]int, len(nums))

    for i := range nums {
        parent[i] = i
        size[i] = 1
        sum[i] = nums[i]
    }

    var find func(int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    union := func(x, y int) {
        xRoot := find(x)
        yRoot := find(y)
        if xRoot == yRoot {
            return
        }
        if size[xRoot] < size[yRoot] {
            xRoot, yRoot = yRoot, xRoot
        }
        parent[yRoot] = xRoot
        size[xRoot] += size[yRoot]
        sum[xRoot] += sum[yRoot]
    }

    maxSum := 0
    for _, r := range remove {
        for i := 0; i < len(nums); i++ {
            if i == r {
                continue
            }
            if find(i) == find(r) {
                union(i, r)
            }
        }
    }

    seen := make(map[int]bool)
    for i := 0; i < len(nums); i++ {
        root := find(i)
        if !seen[root] {
            seen[root] = true
            if sum[root] > maxSum {
                maxSum = sum[root]
            }
        }
    }

    return int64(maxSum)
}