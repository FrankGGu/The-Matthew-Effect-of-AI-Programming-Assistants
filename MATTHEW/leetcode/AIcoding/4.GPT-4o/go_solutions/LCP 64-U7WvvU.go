/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func bulbSwitch(root *TreeNode) int {
    if root == nil {
        return 0
    }
    return dfs(root, false)
}

func dfs(node *TreeNode, parentOn bool) int {
    if node == nil {
        return 0
    }
    on := parentOn || (node.Val%2 == 1)
    leftCount := dfs(node.Left, on)
    rightCount := dfs(node.Right, on)
    if on {
        return 1 + leftCount + rightCount
    }
    return leftCount + rightCount
}