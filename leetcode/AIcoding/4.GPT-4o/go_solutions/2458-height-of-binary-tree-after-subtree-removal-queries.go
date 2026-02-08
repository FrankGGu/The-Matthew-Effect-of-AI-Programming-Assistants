type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func treeQueries(root *TreeNode, queries []int) []int {
    var heights []int
    var nodes map[int]*TreeNode = make(map[int]*TreeNode)
    var depth []int

    var dfs func(node *TreeNode, h int) int
    dfs = func(node *TreeNode, h int) int {
        if node == nil {
            return h
        }
        heights = append(heights, h)
        nodes[node.Val] = node
        leftHeight := dfs(node.Left, h+1)
        rightHeight := dfs(node.Right, h+1)
        return max(leftHeight, rightHeight)
    }

    dfs(root, 0)

    maxHeight := make([]int, len(heights))
    maxHeight[len(maxHeight)-1] = heights[len(heights)-1]
    for i := len(maxHeight) - 2; i >= 0; i-- {
        maxHeight[i] = max(maxHeight[i+1], heights[i])
    }

    result := make([]int, len(queries))
    for i, query := range queries {
        nodeHeight := heights[nodes[query].Val-1]
        if nodeHeight == maxHeight[0] {
            result[i] = maxHeight[1]
        } else {
            result[i] = maxHeight[0]
        }
    }

    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}