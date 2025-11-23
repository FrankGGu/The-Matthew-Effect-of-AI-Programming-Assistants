package main

func highestPeak(photos [][]int) [][]int {
    m, n := len(photos), len(photos[0])
    q := [][]int{}
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if photos[i][j] == 0 {
                q = append(q, []int{i, j})
            } else {
                photos[i][j] = -1
            }
        }
    }

    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    for len(q) > 0 {
        cell := q[0]
        q = q[1:]
        for _, dir := range directions {
            x, y := cell[0]+dir[0], cell[1]+dir[1]
            if x >= 0 && x < m && y >= 0 && y < n && photos[x][y] == -1 {
                photos[x][y] = photos[cell[0]][cell[1]] + 1
                q = append(q, []int{x, y})
            }
        }
    }
    return photos
}