type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func findSubtreeSizes(root *TreeNode, queries []int) []int {
    sizeMap := make(map[int]int)
    var dfs func(node *TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        size := 1 + dfs(node.Left) + dfs(node.Right)
        sizeMap[node.Val] = size
        return size
    }
    dfs(root)

    result := make([]int, len(queries))
    for i, val := range queries {
        result[i] = sizeMap[val]
    }
    return result
}