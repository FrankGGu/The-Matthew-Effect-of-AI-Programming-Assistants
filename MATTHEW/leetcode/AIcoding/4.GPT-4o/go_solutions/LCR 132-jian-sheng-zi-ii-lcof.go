func cutOffTree(forest [][]int) int {
    type Point struct {
        x, y int
    }

    targetTrees := []Point{}
    for i := range forest {
        for j := range forest[i] {
            if forest[i][j] > 1 {
                targetTrees = append(targetTrees, Point{i, j})
            }
        }
    }

    sort.Slice(targetTrees, func(i, j int) bool {
        return forest[targetTrees[i].x][targetTrees[i].y] < forest[targetTrees[j].x][targetTrees[j].y]
    })

    start := Point{0, 0}
    totalSteps := 0

    bfs := func(start Point, end Point) int {
        if start == end {
            return 0
        }
        queue := []Point{start}
        visited := make(map[Point]bool)
        visited[start] = true
        steps := 0
        directions := []Point{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}

        for len(queue) > 0 {
            steps++
            nextQueue := []Point{}
            for _, p := range queue {
                for _, d := range directions {
                    nx, ny := p.x+d.x, p.y+d.y
                    if nx >= 0 && nx < len(forest) && ny >= 0 && ny < len(forest[0]) && !visited[Point{nx, ny}] && forest[nx][ny] != 0 {
                        if Point{nx, ny} == end {
                            return steps
                        }
                        visited[Point{nx, ny}] = true
                        nextQueue = append(nextQueue, Point{nx, ny})
                    }
                }
            }
            queue = nextQueue
        }
        return -1
    }

    for _, tree := range targetTrees {
        steps := bfs(start, tree)
        if steps == -1 {
            return -1
        }
        totalSteps += steps
        start = tree
    }

    return totalSteps
}