package main

func minMovesToCleanTheClassroom(m: int, n: int, k: int, a []int, b []int) int {
    type pos struct {
        x, y int
    }
    seen := make(map[pos]bool)
    queue := []pos{}
    for i := 0; i < k; i++ {
        queue = append(queue, pos{a[i], b[i]})
        seen[pos{a[i], b[i]}] = true
    }
    dirs := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    moves := 0
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]
            if current.x == 0 || current.x == m-1 || current.y == 0 || current.y == n-1 {
                return moves
            }
            for _, d := range dirs {
                nx, ny := current.x+d[0], current.y+d[1]
                if nx >= 0 && nx < m && ny >= 0 && ny < n {
                    p := pos{nx, ny}
                    if !seen[p] {
                        seen[p] = true
                        queue = append(queue, p)
                    }
                }
            }
        }
        moves++
    }
    return -1
}