/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func maxAncestorDiff(root *TreeNode) int {
    if root == nil {
        return 0
    }
    return helper(root, root.Val, root.Val)
}

func helper(node *TreeNode, minVal, maxVal int) int {
    if node == nil {
        return maxVal - minVal
    }
    minVal = min(minVal, node.Val)
    maxVal = max(maxVal, node.Val)
    left := helper(node.Left, minVal, maxVal)
    right := helper(node.Right, minVal, maxVal)
    return max(left, right)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}