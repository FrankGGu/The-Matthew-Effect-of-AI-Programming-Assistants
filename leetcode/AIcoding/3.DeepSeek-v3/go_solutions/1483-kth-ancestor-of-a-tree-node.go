type TreeAncestor struct {
    up [][]int
    maxPow int
}

func Constructor(n int, parent []int) TreeAncestor {
    maxPow := 20
    up := make([][]int, n)
    for i := 0; i < n; i++ {
        up[i] = make([]int, maxPow)
        up[i][0] = parent[i]
        for j := 1; j < maxPow; j++ {
            up[i][j] = -1
            if up[i][j-1] != -1 {
                up[i][j] = up[up[i][j-1]][j-1]
            }
        }
    }
    return TreeAncestor{up, maxPow}
}

func (this *TreeAncestor) GetKthAncestor(node int, k int) int {
    for p := 0; p < this.maxPow; p++ {
        if (k >> p) & 1 == 1 {
            node = this.up[node][p]
            if node == -1 {
                return -1
            }
        }
    }
    return node
}