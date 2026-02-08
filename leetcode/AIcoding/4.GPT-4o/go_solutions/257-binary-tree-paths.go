/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func binaryTreePaths(root *TreeNode) []string {
    if root == nil {
        return []string{}
    }
    var paths []string
    var dfs func(node *TreeNode, path string)
    dfs = func(node *TreeNode, path string) {
        if node != nil {
            path += strconv.Itoa(node.Val)
            if node.Left == nil && node.Right == nil {
                paths = append(paths, path)
            } else {
                path += "->"
                dfs(node.Left, path)
                dfs(node.Right, path)
            }
        }
    }
    dfs(root, "")
    return paths
}