func findLatestStep(arr []int, m int) int {
    n := len(arr)
    if n == m {
        return n
    }
    parent := make([]int, n+2)
    size := make([]int, n+2)
    count := make([]int, n+2)
    res := -1

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

    union := func(x, y int) {
        xRoot := find(x)
        yRoot := find(y)
        if xRoot == yRoot {
            return
        }
        count[size[xRoot]]--
        count[size[yRoot]]--
        parent[yRoot] = xRoot
        size[xRoot] += size[yRoot]
        count[size[xRoot]]++
    }

    for step, pos := range arr {
        count[1]++
        if parent[pos-1] != pos-1 {
            union(pos-1, pos)
        }
        if parent[pos+1] != pos+1 {
            union(pos, pos+1)
        }
        if count[m] > 0 {
            res = step + 1
        }
    }
    return res
}