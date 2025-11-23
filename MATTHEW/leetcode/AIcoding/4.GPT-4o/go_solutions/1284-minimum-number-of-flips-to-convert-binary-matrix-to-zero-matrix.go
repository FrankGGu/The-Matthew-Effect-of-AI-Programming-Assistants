func minFlips(mat [][]int) int {
    m, n := len(mat), len(mat[0])
    target := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            target |= (mat[i][j] << (i*n + j))
        }
    }

    queue := []int{target}
    visited := map[int]bool{target: true}
    flips := 0

    directions := []struct{ dx, dy int }{
        {0, 0}, {0, 1}, {0, -1}, {1, 0}, {-1, 0},
    }

    for len(queue) > 0 {
        flips++
        for size := len(queue); size > 0; size-- {
            curr := queue[0]
            queue = queue[1:]

            if curr == 0 {
                return flips - 1
            }

            for i := 0; i < m; i++ {
                for j := 0; j < n; j++ {
                    next := curr
                    for _, d := range directions {
                        ni, nj := i+d.dx, j+d.dy
                        if ni >= 0 && ni < m && nj >= 0 && nj < n {
                            next ^= (1 << (ni*n + nj))
                        }
                    }
                    if !visited[next] {
                        visited[next] = true
                        queue = append(queue, next)
                    }
                }
            }
        }
    }

    return -1
}