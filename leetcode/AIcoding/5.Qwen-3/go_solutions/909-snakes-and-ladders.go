package main

func snakesAndLadders(board [][]int) int {
    n := len(board)
    target := n * n

    visited := make(map[int]bool)
    queue := []int{1}
    visited[1] = true

    steps := 0

    for len(queue) > 0 {
        for _, node := range queue {
            if node == target {
                return steps
            }
            for i := 1; i <= 6; i++ {
                next := node + i
                if next > target {
                    break
                }
                r, c := getCoordinates(n, next)
                if board[r][c] != -1 {
                    next = board[r][c]
                }
                if !visited[next] {
                    visited[next] = true
                    queue = append(queue, next)
                }
            }
        }
        queue = queue[1:]
        steps++
    }

    return -1
}

func getCoordinates(n, num int) (int, int) {
    num--
    r := n - 1 - num/n
    c := num%n
    if (n-r)%2 == 0 {
        c = n - 1 - c
    }
    return r, c
}