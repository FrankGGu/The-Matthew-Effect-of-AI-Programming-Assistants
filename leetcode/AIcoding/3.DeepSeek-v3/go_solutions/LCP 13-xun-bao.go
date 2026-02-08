func minimalSteps(maze []string) int {
    dirs := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    m, n := len(maze), len(maze[0])
    var start, end [2]int
    var stones, machines [][2]int
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            switch maze[i][j] {
            case 'S':
                start = [2]int{i, j}
            case 'T':
                end = [2]int{i, j}
            case 'O':
                stones = append(stones, [2]int{i, j})
            case 'M':
                machines = append(machines, [2]int{i, j})
            }
        }
    }
    k := len(machines)
    if k == 0 {
        return bfs(start, end, maze)
    }

    distStart := make([][]int, m)
    for i := range distStart {
        distStart[i] = make([]int, n)
        for j := range distStart[i] {
            distStart[i][j] = -1
        }
    }
    q := [][2]int{start}
    distStart[start[0]][start[1]] = 0
    for len(q) > 0 {
        p := q[0]
        q = q[1:]
        for _, d := range dirs {
            x, y := p[0]+d[0], p[1]+d[1]
            if x >= 0 && x < m && y >= 0 && y < n && maze[x][y] != '#' && distStart[x][y] == -1 {
                distStart[x][y] = distStart[p[0]][p[1]] + 1
                q = append(q, [2]int{x, y})
            }
        }
    }

    distStone := make([][][]int, len(stones))
    for i := range distStone {
        distStone[i] = make([][]int, m)
        for j := range distStone[i] {
            distStone[i][j] = make([]int, n)
            for k := range distStone[i][j] {
                distStone[i][j][k] = -1
            }
        }
        q := [][2]int{stones[i]}
        distStone[i][stones[i][0]][stones[i][1]] = 0
        for len(q) > 0 {
            p := q[0]
            q = q[1:]
            for _, d := range dirs {
                x, y := p[0]+d[0], p[1]+d[1]
                if x >= 0 && x < m && y >= 0 && y < n && maze[x][y] != '#' && distStone[i][x][y] == -1 {
                    distStone[i][x][y] = distStone[i][p[0]][p[1]] + 1
                    q = append(q, [2]int{x, y})
                }
            }
        }
    }

    distMachine := make([][][]int, k)
    for i := range distMachine {
        distMachine[i] = make([][]int, m)
        for j := range distMachine[i] {
            distMachine[i][j] = make([]int, n)
            for l := range distMachine[i][j] {
                distMachine[i][j][l] = -1
            }
        }
        q := [][2]int{machines[i]}
        distMachine[i][machines[i][0]][machines[i][1]] = 0
        for len(q) > 0 {
            p := q[0]
            q = q[1:]
            for _, d := range dirs {
                x, y := p[0]+d[0], p[1]+d[1]
                if x >= 0 && x < m && y >= 0 && y < n && maze[x][y] != '#' && distMachine[i][x][y] == -1 {
                    distMachine[i][x][y] = distMachine[i][p[0]][p[1]] + 1
                    q = append(q, [2]int{x, y})
                }
            }
        }
    }

    distEnd := make([][]int, m)
    for i := range distEnd {
        distEnd[i] = make([]int, n)
        for j := range distEnd[i] {
            distEnd[i][j] = -1
        }
    }
    q = [][2]int{end}
    distEnd[end[0]][end[1]] = 0
    for len(q) > 0 {
        p := q[0]
        q = q[1:]
        for _, d := range dirs {
            x, y := p[0]+d[0], p[1]+d[1]
            if x >= 0 && x < m && y >= 0 && y < n && maze[x][y] != '#' && distEnd[x][y] == -1 {
                distEnd[x][y] = distEnd[p[0]][p[1]] + 1
                q = append(q, [2]int{x, y})
            }
        }
    }

    startToStone := make([][]int, k)
    for i := range startToStone {
        startToStone[i] = make([]int, len(stones))
        for j := range startToStone[i] {
            startToStone[i][j] = -1
            if distStart[machines[i][0]][machines[i][1]] != -1 && distStone[j][machines[i][0]][machines[i][1]] != -1 {
                startToStone[i][j] = distStart[machines[i][0]][machines[i][1]] + distStone[j][machines[i][0]][machines[i][1]]
            }
        }
    }

    stoneToMachine := make([][]int, len(stones))
    for i := range stoneToMachine {
        stoneToMachine[i] = make([]int, k)
        for j := range stoneToMachine[i] {
            stoneToMachine[i][j] = -1
            if distMachine[j][stones[i][0]][stones[i][1]] != -1 {
                stoneToMachine[i][j] = distMachine[j][stones[i][0]][stones[i][1]]
            }
        }
    }

    machineToEnd := make([]int, k)
    for i := range machineToEnd {
        machineToEnd[i] = -1
        if distEnd[machines[i][0]][machines[i][1]] != -1 {
            machineToEnd[i] = distEnd[machines[i][0]][machines[i][1]]
        }
    }

    dp := make([][]int, 1<<k)
    for i := range dp {
        dp[i] = make([]int, k)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }

    for i := 0; i < k; i++ {
        for j := 0; j < len(stones); j++ {
            if startToStone[i][j] != -1 {
                if dp[1<<i][i] == -1 || dp[1<<i][i] > startToStone[i][j] {
                    dp[1<<i][i] = startToStone[i][j]
                }
            }
        }
    }

    for mask := 0; mask < (1 << k); mask++ {
        for i := 0; i < k; i++ {
            if (mask>>i)&1 == 0 {
                continue
            }
            if dp[mask][i] == -1 {
                continue
            }
            for j := 0; j < k; j++ {
                if (mask>>j)&1 == 1 {
                    continue
                }
                minDist := -1
                for s := 0; s < len(stones); s++ {
                    if stoneToMachine[s][j] == -1 {
                        continue
                    }
                    if startToStone[j][s] == -1 {
                        continue
                    }
                    total := dp[mask][i] + stoneToMachine[s][j]
                    if minDist == -1 || total < minDist {
                        minDist = total
                    }
                }
                if minDist == -1 {
                    continue
                }
                newMask := mask | (1 << j)
                if dp[newMask][j] == -1 || dp[newMask][j] > minDist {
                    dp[newMask][j] = minDist
                }
            }
        }
    }

    finalMask := (1 << k) - 1
    res := -1
    for i := 0; i < k; i++ {
        if dp[finalMask][i] == -1 || machineToEnd[i] == -1 {
            continue
        }
        total