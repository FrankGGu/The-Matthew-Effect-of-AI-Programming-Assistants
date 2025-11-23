/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func sumRootToLeaf(root *TreeNode) int {
    sum := 0
    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, current int) {
        if node == nil {
            return
        }
        current = (current << 1) | node.Val
        if node.Left == nil && node.Right == nil {
            sum += current
            return
        }
        dfs(node.Left, current)
        dfs(node.Right, current)
    }
    dfs(root, 0)
    return sum
}