func minSwaps(grid [][]int) int {
    n := len(grid)
    zeros := make([]int, n)

    for i := 0; i < n; i++ {
        cnt := 0
        for j := n-1; j >= 0; j-- {
            if grid[i][j] == 0 {
                cnt++
            } else {
                break
            }
        }
        zeros[i] = cnt
    }

    res := 0

    for i := 0; i < n; i++ {
        req := n - 1 - i
        if zeros[i] >= req {
            continue
        }
        found := -1
        for j := i + 1; j < n; j++ {
            if zeros[j] >= req {
                found = j
                break
            }
        }
        if found == -1 {
            return -1
        }
        for j := found; j > i; j-- {
            zeros[j], zeros[j-1] = zeros[j-1], zeros[j]
            res++
        }
    }

    return res
}