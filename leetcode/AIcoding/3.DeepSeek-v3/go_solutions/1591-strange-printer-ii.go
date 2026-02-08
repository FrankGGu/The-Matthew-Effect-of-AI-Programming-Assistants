func isPrintable(targetGrid [][]int) bool {
    m, n := len(targetGrid), len(targetGrid[0])
    colors := make(map[int]struct{})
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            colors[targetGrid[i][j]] = struct{}{}
        }
    }

    adj := make(map[int]map[int]struct{})
    for c := range colors {
        adj[c] = make(map[int]struct{})
    }

    for c := range colors {
        minX, minY := m, n
        maxX, maxY := -1, -1
        for i := 0; i < m; i++ {
            for j := 0; j < n; j++ {
                if targetGrid[i][j] == c {
                    if i < minX {
                        minX = i
                    }
                    if i > maxX {
                        maxX = i
                    }
                    if j < minY {
                        minY = j
                    }
                    if j > maxY {
                        maxY = j
                    }
                }
            }
        }

        for i := minX; i <= maxX; i++ {
            for j := minY; j <= maxY; j++ {
                if targetGrid[i][j] != c {
                    adj[c][targetGrid[i][j]] = struct{}{}
                }
            }
        }
    }

    inDegree := make(map[int]int)
    for c := range colors {
        inDegree[c] = 0
    }
    for u := range adj {
        for v := range adj[u] {
            inDegree[v]++
        }
    }

    queue := make([]int, 0)
    for c := range inDegree {
        if inDegree[c] == 0 {
            queue = append(queue, c)
        }
    }

    count := 0
    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        count++
        for v := range adj[u] {
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    return count == len(colors)
}