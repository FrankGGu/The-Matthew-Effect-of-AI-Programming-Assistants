/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func findTarget(root *TreeNode, k int) bool {
    m := make(map[int]bool)
    return helper(root, k, m)
}

func helper(root *TreeNode, k int, m map[int]bool) bool {
    if root == nil {
        return false
    }
    if m[k - root.Val] {
        return true
    }
    m[root.Val] = true
    return helper(root.Left, k, m) || helper(root.Right, k, m)
}