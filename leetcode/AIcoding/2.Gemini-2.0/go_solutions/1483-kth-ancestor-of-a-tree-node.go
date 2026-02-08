type TreeAncestor struct {
    parent [][]int
    depth  []int
}

func Constructor(n int, parent []int) TreeAncestor {
    maxDepth := 0
    for i := 0; i < n; i++ {
        d := 0
        curr := i
        for curr != -1 {
            curr = parent[curr]
            d++
        }
        if d > maxDepth {
            maxDepth = d
        }
    }

    maxK := 1
    for maxK <= maxDepth {
        maxK *= 2
    }
    maxK /= 2
    k := 0
    for 1<<k <= maxK {
        k++
    }

    dp := make([][]int, n)
    for i := 0; i < n; i++ {
        dp[i] = make([]int, k+1)
        for j := 0; j <= k; j++ {
            dp[i][j] = -1
        }
    }

    for i := 0; i < n; i++ {
        dp[i][0] = parent[i]
    }

    for j := 1; j <= k; j++ {
        for i := 0; i < n; i++ {
            if dp[i][j-1] != -1 {
                dp[i][j] = dp[dp[i][j-1]][j-1]
            }
        }
    }

    return TreeAncestor{parent: dp}
}

func (this *TreeAncestor) GetKthAncestor(node int, k int) int {
    for i := 0; i < len(this.parent[0]); i++ {
        if (k>>i)&1 == 1 {
            node = this.parent[node][i]
            if node == -1 {
                return -1
            }
        }
    }
    return node
}