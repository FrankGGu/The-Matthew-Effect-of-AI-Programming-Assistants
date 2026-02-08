/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func longestUnivaluePath(root *TreeNode) int {
    maxLength := 0
    var dfs func(node *TreeNode, val int) int
    dfs = func(node *TreeNode, val int) int {
        if node == nil {
            return 0
        }
        leftLength := dfs(node.Left, node.Val)
        rightLength := dfs(node.Right, node.Val)
        if node.Val == val {
            maxLength = max(maxLength, leftLength+rightLength)
            return max(leftLength, rightLength) + 1
        }
        return 0
    }
    dfs(root, -1)
    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}