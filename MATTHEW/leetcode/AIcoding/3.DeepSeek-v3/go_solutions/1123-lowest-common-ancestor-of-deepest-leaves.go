/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func lcaDeepestLeaves(root *TreeNode) *TreeNode {
    var dfs func(*TreeNode) (*TreeNode, int)
    dfs = func(node *TreeNode) (*TreeNode, int) {
        if node == nil {
            return nil, 0
        }
        left, leftDepth := dfs(node.Left)
        right, rightDepth := dfs(node.Right)
        if leftDepth > rightDepth {
            return left, leftDepth + 1
        }
        if rightDepth > leftDepth {
            return right, rightDepth + 1
        }
        return node, leftDepth + 1
    }
    res, _ := dfs(root)
    return res
}