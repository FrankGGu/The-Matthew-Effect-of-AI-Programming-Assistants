func containVirus(isInfected [][]int) int {
    n := len(isInfected)
    if n == 0 {
        return 0
    }

    totalWalls := 0
    for {
        walls, regions := 0, 0
        visited := make([][]bool, n)
        var bfs func(int, int)

        bfs = func(r, c int) {
            queue := [][]int{{r, c}}
            visited[r][c] = true
            wallsNeeded := 0
            regionSize := 0
            for len(queue) > 0 {
                cur := queue[0]
                queue = queue[1:]
                regionSize++
                for _, d := range [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}} {
                    nr, nc := cur[0]+d[0], cur[1]+d[1]
                    if nr >= 0 && nr < n && nc >= 0 && nc < n {
                        if isInfected[nr][nc] == 1 && !visited[nr][nc] {
                            visited[nr][nc] = true
                            queue = append(queue, []int{nr, nc})
                        } else if isInfected[nr][nc] == 0 {
                            wallsNeeded++
                        }
                    }
                }
            }
            return wallsNeeded, regionSize
        }

        for i := 0; i < n; i++ {
            for j := 0; j < n; j++ {
                if isInfected[i][j] == 1 && !visited[i][j] {
                    regions++
                    wallsNeeded, size := bfs(i, j)
                    walls += wallsNeeded
                    totalWalls += wallsNeeded
                }
            }
        }

        if regions == 0 {
            break
        }

        maxRegion := -1
        for i := 0; i < n; i++ {
            for j := 0; j < n; j++ {
                if isInfected[i][j] == 1 && visited[i][j] {
                    if maxRegion == -1 || size > maxRegion {
                        maxRegion = size
                        isInfected[i][j] = -1
                    }
                }
            }
        }

        for i := 0; i < n; i++ {
            for j := 0; j < n; j++ {
                if isInfected[i][j] == 0 {
                    isInfected[i][j] = 1
                }
                if isInfected[i][j] == -1 {
                    isInfected[i][j] = 1
                }
            }
        }
    }

    return totalWalls
}