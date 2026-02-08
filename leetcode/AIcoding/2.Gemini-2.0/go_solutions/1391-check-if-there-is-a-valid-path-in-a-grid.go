func hasValidPath(grid [][]int) bool {
    m, n := len(grid), len(grid[0])
    parent := make([]int, m*n)
    for i := range parent {
        parent[i] = i
    }

    find := func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    union := func(x, y int) {
        rootX, rootY := find(x), find(y)
        if rootX != rootY {
            parent[rootX] = rootY
        }
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            switch grid[i][j] {
            case 1:
                if j+1 < n && (grid[i][j+1] == 1 || grid[i][j+1] == 4 || grid[i][j+1] == 6) {
                    union(i*n+j, i*n+j+1)
                }
                if j-1 >= 0 && (grid[i][j-1] == 1 || grid[i][j-1] == 3 || grid[i][j-1] == 5) {
                    union(i*n+j, i*n+j-1)
                }
            case 2:
                if i+1 < m && (grid[i+1][j] == 2 || grid[i+1][j] == 3 || grid[i+1][j] == 4) {
                    union(i*n+j, (i+1)*n+j)
                }
                if i-1 >= 0 && (grid[i-1][j] == 2 || grid[i-1][j] == 5 || grid[i-1][j] == 6) {
                    union(i*n+j, (i-1)*n+j)
                }
            case 3:
                if j-1 >= 0 && (grid[i][j-1] == 1 || grid[i][j-1] == 3 || grid[i][j-1] == 5) {
                    union(i*n+j, i*n+j-1)
                }
                if i+1 < m && (grid[i+1][j] == 2 || grid[i+1][j] == 3 || grid[i+1][j] == 4) {
                    union(i*n+j, (i+1)*n+j)
                }
            case 4:
                if j+1 < n && (grid[i][j+1] == 1 || grid[i][j+1] == 4 || grid[i][j+1] == 6) {
                    union(i*n+j, i*n+j+1)
                }
                if i+1 < m && (grid[i+1][j] == 2 || grid[i+1][j] == 3 || grid[i+1][j] == 4) {
                    union(i*n+j, (i+1)*n+j)
                }
            case 5:
                if j-1 >= 0 && (grid[i][j-1] == 1 || grid[i][j-1] == 3 || grid[i][j-1] == 5) {
                    union(i*n+j, i*n+j-1)
                }
                if i-1 >= 0 && (grid[i-1][j] == 2 || grid[i-1][j] == 5 || grid[i-1][j] == 6) {
                    union(i*n+j, (i-1)*n+j)
                }
            case 6:
                if j+1 < n && (grid[i][j+1] == 1 || grid[i][j+1] == 4 || grid[i][j+1] == 6) {
                    union(i*n+j, i*n+j+1)
                }
                if i-1 >= 0 && (grid[i-1][j] == 2 || grid[i-1][j] == 5 || grid[i-1][j] == 6) {
                    union(i*n+j, (i-1)*n+j)
                }
            }
        }
    }

    return find(0) == find(m*n-1)
}