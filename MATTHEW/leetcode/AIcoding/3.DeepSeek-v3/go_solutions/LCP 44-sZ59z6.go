/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func numColor(root *TreeNode) int {
    colorSet := make(map[int]bool)
    var dfs func(node *TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }
        colorSet[node.Val] = true
        dfs(node.Left)
        dfs(node.Right)
    }
    dfs(root)
    return len(colorSet)
}