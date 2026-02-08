/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func sufficientSubset(root *TreeNode, limit int) *TreeNode {
    if root == nil {
        return nil
    }

    if !dfs(root, 0, limit) {
        return nil
    }

    return root
}

func dfs(node *TreeNode, currentSum int, limit int) bool {
    if node == nil {
        return false
    }

    currentSum += node.Val

    if node.Left == nil && node.Right == nil {
        return currentSum >= limit
    }

    leftSufficient := dfs(node.Left, currentSum, limit)
    rightSufficient := dfs(node.Right, currentSum, limit)

    if !leftSufficient {
        node.Left = nil
    }
    if !rightSufficient {
        node.Right = nil
    }

    return leftSufficient || rightSufficient
}