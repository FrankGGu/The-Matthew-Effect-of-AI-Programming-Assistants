type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

type TreeAncestor struct {
    parent [][]int
}

func Constructor(n int, ancestor [][]int) TreeAncestor {
    maxLog := 0
    for (1 << maxLog) <= n {
        maxLog++
    }

    parent := make([][]int, n)
    for i := range parent {
        parent[i] = make([]int, maxLog)
        for j := range parent[i] {
            parent[i][j] = -1
        }
    }

    for _, pair := range ancestor {
        child, par := pair[0], pair[1]
        parent[child][0] = par
    }

    for j := 1; j < maxLog; j++ {
        for i := 0; i < n; i++ {
            if parent[i][j-1] != -1 {
                parent[i][j] = parent[parent[i][j-1]][j-1]
            }
        }
    }

    return TreeAncestor{parent: parent}
}

func (this *TreeAncestor) GetKthAncestor(node int, k int) int {
    for j := 0; k > 0 && node != -1; j++ {
        if (k & 1) == 1 {
            node = this.parent[node][j]
        }
        k >>= 1
    }
    return node
}