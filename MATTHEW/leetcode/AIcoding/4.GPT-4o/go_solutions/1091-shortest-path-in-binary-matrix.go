import "container/list"

func shortestPathBinaryMatrix(grid [][]int) int {
    if grid[0][0] == 1 || grid[len(grid)-1][len(grid[0])-1] == 1 {
        return -1
    }
    directions := [][2]int{{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}}
    queue := list.New()
    queue.PushBack([2]int{0, 0})
    grid[0][0] = 1
    pathLength := 1

    for queue.Len() > 0 {
        for i := queue.Len(); i > 0; i-- {
            cell := queue.Remove(queue.Front()).([2]int)
            x, y := cell[0], cell[1]
            if x == len(grid)-1 && y == len(grid[0])-1 {
                return pathLength
            }
            for _, d := range directions {
                nx, ny := x+d[0], y+d[1]
                if nx >= 0 && nx < len(grid) && ny >= 0 && ny < len(grid[0]) && grid[nx][ny] == 0 {
                    grid[nx][ny] = 1
                    queue.PushBack([2]int{nx, ny})
                }
            }
        }
        pathLength++
    }
    return -1
}