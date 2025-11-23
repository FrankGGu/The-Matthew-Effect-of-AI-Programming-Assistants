package main

func zigzagGridTraversal(grid [][]int, skip int) []int {
    rows := len(grid)
    cols := len(grid[0])
    result := make([]int, 0)
    direction := 1
    i, j := 0, 0

    for i < rows && j < cols {
        if skip > 0 {
            skip--
            if direction == 1 {
                j++
                if j >= cols {
                    i++
                    direction = -1
                }
            } else {
                j--
                if j < 0 {
                    i++
                    direction = 1
                }
            }
            continue
        }

        result = append(result, grid[i][j])

        if direction == 1 {
            j++
            if j >= cols {
                i++
                direction = -1
            }
        } else {
            j--
            if j < 0 {
                i++
                direction = 1
            }
        }
    }

    return result
}