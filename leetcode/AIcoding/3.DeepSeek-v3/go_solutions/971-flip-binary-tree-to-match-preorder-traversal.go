/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func flipMatchVoyage(root *TreeNode, voyage []int) []int {
    res := make([]int, 0)
    idx := 0
    var dfs func(*TreeNode) bool
    dfs = func(node *TreeNode) bool {
        if node == nil {
            return true
        }
        if node.Val != voyage[idx] {
            return false
        }
        idx++
        if node.Left != nil && node.Left.Val != voyage[idx] {
            res = append(res, node.Val)
            return dfs(node.Right) && dfs(node.Left)
        }
        return dfs(node.Left) && dfs(node.Right)
    }
    if dfs(root) {
        return res
    }
    return []int{-1}
}