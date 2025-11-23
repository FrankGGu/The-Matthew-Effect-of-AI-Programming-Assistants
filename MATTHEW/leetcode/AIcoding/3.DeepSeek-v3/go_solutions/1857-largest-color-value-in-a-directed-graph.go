func largestPathValue(colors string, edges [][]int) int {
    n := len(colors)
    adj := make([][]int, n)
    inDegree := make([]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        inDegree[v]++
    }

    queue := []int{}
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    cnt := make([][]int, n)
    for i := range cnt {
        cnt[i] = make([]int, 26)
    }

    res := 0
    processed := 0
    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        processed++
        c := int(colors[u] - 'a')
        cnt[u][c]++
        res = max(res, cnt[u][c])
        for _, v := range adj[u] {
            for i := 0; i < 26; i++ {
                if cnt[u][i] > cnt[v][i] {
                    cnt[v][i] = cnt[u][i]
                }
            }
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    if processed != n {
        return -1
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}