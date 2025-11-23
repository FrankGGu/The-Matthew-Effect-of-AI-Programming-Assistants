func snakesAndLadders(board [][]int) int {
    n := len(board)
    vertices := n * n
    adj := make([][]int, vertices+1)

    for i := 1; i <= vertices; i++ {
        for j := 1; j <= 6; j++ {
            next := i + j
            if next > vertices {
                break
            }

            row := (next - 1) / n
            col := (next - 1) % n

            row = n - 1 - row
            if (n % 2 == 0 && ((n - 1 - row) % 2) != 0) || (n % 2 != 0 && ((n - 1 - row) % 2) == 0) {
                col = n - 1 - col
            }

            if board[row][col] != -1 {
                next = board[row][col]
            }
            adj[i] = append(adj[i], next)
        }
    }

    queue := []int{1}
    visited := make([]bool, vertices+1)
    visited[1] = true
    dist := make([]int, vertices+1)

    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]

        if u == vertices {
            return dist[u]
        }

        for _, v := range adj[u] {
            if !visited[v] {
                visited[v] = true
                dist[v] = dist[u] + 1
                queue = append(queue, v)
            }
        }
    }

    return -1
}