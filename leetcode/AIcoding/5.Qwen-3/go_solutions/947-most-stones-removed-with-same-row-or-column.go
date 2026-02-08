package main

func removeStones(stones [][]int) int {
    parent := make(map[int]int)
    var find func(x int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }
    var union func(x, y int)
    union = func(x, y int) {
        px := find(x)
        py := find(y)
        if px != py {
            parent[px] = py
        }
    }
    for _, stone := range stones {
        x, y := stone[0], stone[1]
        if _, ok := parent[x]; !ok {
            parent[x] = x
        }
        if _, ok := parent[y+10001]; !ok {
            parent[y+10001] = y + 10001
        }
        union(x, y+10001)
    }
    seen := make(map[int]bool)
    for _, stone := range stones {
        x, y := stone[0], stone[1]
        root := find(x)
        if !seen[root] {
            seen[root] = true
        }
    }
    return len(stones) - len(seen)
}