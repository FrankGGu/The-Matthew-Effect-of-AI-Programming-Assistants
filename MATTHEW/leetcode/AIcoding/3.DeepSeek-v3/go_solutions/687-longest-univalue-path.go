/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func longestUnivaluePath(root *TreeNode) int {
    maxLen := 0
    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        leftLen, rightLen := 0, 0
        if node.Left != nil && node.Left.Val == node.Val {
            leftLen = left + 1
        }
        if node.Right != nil && node.Right.Val == node.Val {
            rightLen = right + 1
        }
        if leftLen + rightLen > maxLen {
            maxLen = leftLen + rightLen
        }
        if leftLen > rightLen {
            return leftLen
        }
        return rightLen
    }
    dfs(root)
    return maxLen
}