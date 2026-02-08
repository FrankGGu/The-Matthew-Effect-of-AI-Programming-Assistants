package main

func hitBricks(bricks [][]int, hits [][]int) []int {
    rows, cols := len(bricks), len(bricks[0])
    directions := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i < 0 || i >= rows || j < 0 || j >= cols || bricks[i][j] != 1 {
            return 0
        }
        bricks[i][j] = 2
        res := 1
        for _, d := range directions {
            res += dfs(i+d[0], j+d[1])
        }
        return res
    }

    for _, hit := range hits {
        i, j := hit[0], hit[1]
        if i >= 0 && i < rows && j >= 0 && j < cols && bricks[i][j] == 1 {
            bricks[i][j] = 0
        }
    }

    result := make([]int, len(hits))
    for i := len(hits) - 1; i >= 0; i-- {
        hit := hits[i]
        x, y := hit[0], hit[1]
        if x < 0 || x >= rows || y < 0 || y >= cols || bricks[x][y] != 0 {
            continue
        }
        bricks[x][y] = 1
        if x == 0 {
            result[i] = dfs(x, y) - 1
        } else {
            result[i] = 0
            for _, d := range directions {
                nx, ny := x+d[0], y+d[1]
                if nx >= 0 && nx < rows && ny >= 0 && ny < cols && bricks[nx][ny] == 2 {
                    result[i] += dfs(nx, ny)
                }
            }
        }
    }

    return result
}