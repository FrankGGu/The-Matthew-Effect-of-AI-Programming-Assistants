func findAllPeople(n int, meetings [][]int, firstPerson int) []int {
    parent := make([]int, n)
    for i := range parent {
        parent[i] = i
    }

    var find func(int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    union := func(x, y int) {
        xRoot, yRoot := find(x), find(y)
        if xRoot != yRoot {
            parent[yRoot] = xRoot
        }
    }

    union(0, firstPerson)

    timeMap := make(map[int][][]int)
    for _, meeting := range meetings {
        x, y, t := meeting[0], meeting[1], meeting[2]
        timeMap[t] = append(timeMap[t], []int{x, y})
    }

    times := make([]int, 0, len(timeMap))
    for t := range timeMap {
        times = append(times, t)
    }
    sort.Ints(times)

    for _, t := range times {
        connections := timeMap[t]
        for _, conn := range connections {
            x, y := conn[0], conn[1]
            union(x, y)
        }
        for _, conn := range connections {
            x, y := conn[0], conn[1]
            if find(x) != find(0) {
                parent[x] = x
            }
            if find(y) != find(0) {
                parent[y] = y
            }
        }
    }

    result := []int{}
    for i := 0; i < n; i++ {
        if find(i) == find(0) {
            result = append(result, i)
        }
    }
    return result
}