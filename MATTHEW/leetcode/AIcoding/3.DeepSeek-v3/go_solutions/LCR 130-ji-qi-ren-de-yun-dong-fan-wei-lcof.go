func wardrobeFinishing(m int, n int, cnt int) int {
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    return dfs(0, 0, m, n, cnt, visited)
}

func dfs(i, j, m, n, cnt int, visited [][]bool) int {
    if i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || digitSum(i)+digitSum(j) > cnt {
        return 0
    }
    visited[i][j] = true
    return 1 + dfs(i+1, j, m, n, cnt, visited) + dfs(i, j+1, m, n, cnt, visited)
}

func digitSum(num int) int {
    sum := 0
    for num > 0 {
        sum += num % 10
        num /= 10
    }
    return sum
}