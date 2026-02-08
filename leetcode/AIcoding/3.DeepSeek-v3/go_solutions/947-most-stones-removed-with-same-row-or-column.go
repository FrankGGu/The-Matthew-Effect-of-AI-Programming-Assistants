func removeStones(stones [][]int) int {
    parent := make(map[int]int)
    count := 0

    var find func(int) int
    find = func(x int) int {
        if _, ok := parent[x]; !ok {
            parent[x] = x
            count++
        }
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    for _, stone := range stones {
        x := stone[0] + 10001
        y := stone[1]
        px := find(x)
        py := find(y)
        if px != py {
            parent[px] = py
            count--
        }
    }

    return len(stones) - count
}