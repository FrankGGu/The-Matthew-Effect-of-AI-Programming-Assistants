type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func minScore(root *TreeNode) int {
    if root == nil {
        return 0
    }

    values := []int{}
    var dfs func(node *TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }
        values = append(values, node.Val)
        dfs(node.Left)
        dfs(node.Right)
    }

    dfs(root)

    minVal := values[0]
    for _, v := range values {
        if v < minVal {
            minVal = v
        }
    }

    return minVal
}