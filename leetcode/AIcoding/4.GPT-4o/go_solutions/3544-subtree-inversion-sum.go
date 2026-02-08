/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func subtreeSum(root *TreeNode) int {
    if root == nil {
        return 0
    }
    return root.Val + subtreeSum(root.Left) + subtreeSum(root.Right)
}

func maxInversionSum(root *TreeNode) int {
    if root == nil {
        return 0
    }

    maxSum := maxInversionSum(root.Left)
    if sum := subtreeSum(root); sum > maxSum {
        maxSum = sum
    }
    if rightSum := maxInversionSum(root.Right); rightSum > maxSum {
        maxSum = rightSum
    }

    return maxSum
}

func maxSubtreeInversionSum(root *TreeNode) int {
    return maxInversionSum(root)
}