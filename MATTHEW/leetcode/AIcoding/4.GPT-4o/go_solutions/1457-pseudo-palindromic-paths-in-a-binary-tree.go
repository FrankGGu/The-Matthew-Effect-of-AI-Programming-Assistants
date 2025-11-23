/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func pseudoPalindromicPaths(root *TreeNode) int {
    return dfs(root, 0)
}

func dfs(node *TreeNode, count int) int {
    if node == nil {
        return 0
    }

    count ^= (1 << node.Val)

    if node.Left == nil && node.Right == nil {
        if count&count-1 == 0 {
            return 1
        }
        return 0
    }

    return dfs(node.Left, count) + dfs(node.Right, count)
}