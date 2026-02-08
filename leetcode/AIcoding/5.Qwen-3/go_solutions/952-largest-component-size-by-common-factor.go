package main

func largestComponentSize(nums []int) int {
    parent := make([]int, 10001)

    for i := range parent {
        parent[i] = i
    }

    var find func(x int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    union := func(x, y int) {
        px := find(x)
        py := find(y)
        if px != py {
            parent[px] = py
        }
    }

    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    for i := 2; i <= maxNum; i++ {
        for j := i * 2; j <= maxNum; j += i {
            union(i, j)
        }
    }

    count := make(map[int]int)
    maxCount := 0
    for _, num := range nums {
        root := find(num)
        count[root]++
        if count[root] > maxCount {
            maxCount = count[root]
        }
    }

    return maxCount
}