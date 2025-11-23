/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func maxAncestorDiff(root *TreeNode) int {
    return helper(root, root.Val, root.Val)
}

func helper(node *TreeNode, minVal int, maxVal int) int {
    if node == nil {
        return maxVal - minVal
    }
    if node.Val < minVal {
        minVal = node.Val
    }
    if node.Val > maxVal {
        maxVal = node.Val
    }
    leftDiff := helper(node.Left, minVal, maxVal)
    rightDiff := helper(node.Right, minVal, maxVal)
    if leftDiff > rightDiff {
        return leftDiff
    }
    return rightDiff
}