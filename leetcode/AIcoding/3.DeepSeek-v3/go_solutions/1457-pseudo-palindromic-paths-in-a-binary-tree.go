/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func pseudoPalindromicPaths (root *TreeNode) int {
    count := 0
    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, path int) {
        if node == nil {
            return
        }
        path ^= 1 << node.Val
        if node.Left == nil && node.Right == nil {
            if path & (path - 1) == 0 {
                count++
            }
            return
        }
        dfs(node.Left, path)
        dfs(node.Right, path)
    }
    dfs(root, 0)
    return count
}