/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func goodNodes(root *TreeNode) int {
    if root == nil {
        return 0
    }
    return dfs(root, root.Val)
}

func dfs(node *TreeNode, maxVal int) int {
    if node == nil {
        return 0
    }
    res := 0
    if node.Val >= maxVal {
        res = 1
        maxVal = node.Val
    }
    return res + dfs(node.Left, maxVal) + dfs(node.Right, maxVal)
}