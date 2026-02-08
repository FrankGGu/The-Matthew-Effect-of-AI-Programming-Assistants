type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func getCoprimes(root *TreeNode, nodes []int) []int {
    coprimes := make([]int, len(nodes))
    maxVal := 1000
    isCoprime := make([][]bool, maxVal+1)

    for i := 1; i <= maxVal; i++ {
        for j := 1; j <= maxVal; j++ {
            if gcd(i, j) == 1 {
                isCoprime[i][j] = true
            }
        }
    }

    parent := make([]int, maxVal+1)
    depth := make([]int, maxVal+1)
    index := make([]int, maxVal+1)
    var dfs func(node *TreeNode, p, d int)

    dfs = func(node *TreeNode, p, d int) {
        if node == nil {
            return
        }
        parent[node.Val] = p
        depth[node.Val] = d
        index[node.Val] = 1
        dfs(node.Left, node.Val, d+1)
        dfs(node.Right, node.Val, d+1)
    }

    dfs(root, -1, 0)

    last := make(map[int]int)
    for _, node := range nodes {
        if node == -1 {
            coprimes = append(coprimes, -1)
            continue
        }
        lastCoprime := -1
        for val, idx := range last {
            if isCoprime[node][val] {
                if lastCoprime == -1 || depth[val] > depth[lastCoprime] {
                    lastCoprime = val
                }
            }
        }
        if lastCoprime != -1 {
            coprimes = append(coprimes, lastCoprime)
        } else {
            coprimes = append(coprimes, -1)
        }
        last[node] = 1
    }
    return coprimes
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}