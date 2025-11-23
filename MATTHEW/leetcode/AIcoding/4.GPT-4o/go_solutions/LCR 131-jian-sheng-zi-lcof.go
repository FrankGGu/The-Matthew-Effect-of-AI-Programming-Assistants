func cutOffTree(forest [][]int) int {
    if len(forest) == 0 || len(forest[0]) == 0 {
        return 0
    }

    type Tree struct {
        x, y, height int
    }

    trees := []Tree{}
    for i := 0; i < len(forest); i++ {
        for j := 0; j < len(forest[0]); j++ {
            if forest[i][j] > 1 {
                trees = append(trees, Tree{i, j, forest[i][j]})
            }
        }
    }

    sort.Slice(trees, func(i, j int) bool {
        return trees[i].height < trees[j].height
    })

    startX, startY := 0, 0
    totalSteps := 0

    for _, tree := range trees {
        steps := bfs(forest, startX, startY, tree.x, tree.y)
        if steps == -1 {
            return -1
        }
        totalSteps += steps
        startX, startY = tree.x, tree.y
    }

    return totalSteps
}

func bfs(forest [][]int, startX, startY, targetX, targetY int) int {
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    queue := [][]int{{startX, startY}}
    visited := map[[2]int]bool{{startX, startY}: true}
    steps := 0

    for len(queue) > 0 {
        for sz := len(queue); sz > 0; sz-- {
            x, y := queue[0][0], queue[0][1]
            queue = queue[1:]

            if x == targetX && y == targetY {
                return steps
            }

            for _, d := range directions {
                newX, newY := x + d[0], y + d[1]
                if newX >= 0 && newX < len(forest) && newY >= 0 && newY < len(forest[0]) && forest[newX][newY] > 0 && !visited[[2]int{newX, newY}] {
                    visited[[2]int{newX, newY}] = true
                    queue = append(queue, []int{newX, newY})
                }
            }
        }
        steps++
    }

    return -1
}