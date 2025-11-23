func snakesAndLadders(board [][]int) int {
    n := len(board)
    target := n * n
    visited := make([]bool, target+1)
    queue := []int{1}
    visited[1] = true
    steps := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            curr := queue[i]
            if curr == target {
                return steps
            }
            for j := 1; j <= 6 && curr+j <= target; j++ {
                next := curr + j
                if next > target {
                    continue
                }
                r, c := getRowCol(next, n)
                if board[r][c] != -1 {
                    next = board[r][c]
                }
                if !visited[next] {
                    visited[next] = true
                    queue = append(queue, next)
                }
            }
        }
        queue = queue[size:]
        steps++
    }
    return -1
}

func getRowCol(num int, n int) (int, int) {
    row := (num - 1) / n
    col := (num - 1) % n
    if row % 2 == 1 {
        col = n - 1 - col
    }
    row = n - 1 - row
    return row, col
}