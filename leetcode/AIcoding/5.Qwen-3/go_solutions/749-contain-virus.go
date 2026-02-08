package main

func containVirus(isInfected [][]bool) int {
    rows, cols := len(isInfected), len(isInfected[0])
    var total int

    for {
        var bestArea []int
        var bestNeighbor map[int]bool
        var bestScore int

        visited := make([][]bool, rows)
        for i := range visited {
            visited[i] = make([]bool, cols)
        }

        for r := 0; r < rows; r++ {
            for c := 0; c < cols; c++ {
                if isInfected[r][c] && !visited[r][c] {
                    area := [][]int{{r, c}}
                    neighbor := make(map[int]bool)
                    queue := [][]int{{r, c}}
                    visited[r][c] = true

                    for len(queue) > 0 {
                        x, y := queue[0][0], queue[0][1]
                        queue = queue[1:]

                        for _, dir := range [][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}} {
                            nx, ny := x+dir[0], y+dir[1]
                            if nx >= 0 && ny >= 0 && nx < rows && ny < cols {
                                if isInfected[nx][ny] && !visited[nx][ny] {
                                    visited[nx][ny] = true
                                    area = append(area, []int{nx, ny})
                                    queue = append(queue, []int{nx, ny})
                                } else if !isInfected[nx][ny] {
                                    neighbor[nx*cols+ny] = true
                                }
                            }
                        }
                    }

                    score := len(neighbor)
                    if score > bestScore {
                        bestScore = score
                        bestArea = area
                        bestNeighbor = neighbor
                    }
                }
            }

            if bestScore == 0 {
                break
            }

            for _, pos := range bestArea {
                isInfected[pos[0]][pos[1]] = false
            }

            for key := range bestNeighbor {
                r, c := key/cols, key%cols
                isInfected[r][c] = true
            }

            total += len(bestArea)
        }
    }

    return total
}