/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func longestZigZag(root *TreeNode) int {
    maxLen := 0
    var dfs func(*TreeNode, int, int)
    dfs = func(node *TreeNode, left, right int) {
        if node == nil {
            return
        }
        if left > maxLen {
            maxLen = left
        }
        if right > maxLen {
            maxLen = right
        }
        dfs(node.Left, right + 1, 0)
        dfs(node.Right, 0, left + 1)
    }
    dfs(root, 0, 0)
    return maxLen
}