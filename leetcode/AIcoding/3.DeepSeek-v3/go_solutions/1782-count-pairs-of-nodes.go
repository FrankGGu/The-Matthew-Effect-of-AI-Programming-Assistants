func countPairs(n int, edges [][]int, queries []int) []int {
    degree := make([]int, n+1)
    edgeCount := make(map[int]int)

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        if u > v {
            u, v = v, u
        }
        degree[u]++
        degree[v]++
        key := u * (n + 1) + v
        edgeCount[key]++
    }

    sortedDegree := make([]int, n)
    copy(sortedDegree, degree[1:])
    sort.Ints(sortedDegree)

    res := make([]int, len(queries))

    for k, q := range queries {
        total := 0

        left, right := 0, n-1
        for left < right {
            if sortedDegree[left]+sortedDegree[right] > q {
                total += right - left
                right--
            } else {
                left++
            }
        }

        for key, cnt := range edgeCount {
            u := key / (n + 1)
            v := key % (n + 1)
            if degree[u]+degree[v] > q && degree[u]+degree[v]-cnt <= q {
                total--
            }
        }

        res[k] = total
    }

    return res
}