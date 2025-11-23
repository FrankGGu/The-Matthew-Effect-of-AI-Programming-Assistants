/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func goodNodes(root *TreeNode) int {
    return countGoodNodes(root, root.Val)
}

func countGoodNodes(node *TreeNode, maxValue int) int {
    if node == nil {
        return 0
    }
    goodCount := 0
    if node.Val >= maxValue {
        goodCount = 1
        maxValue = node.Val
    }
    goodCount += countGoodNodes(node.Left, maxValue)
    goodCount += countGoodNodes(node.Right, maxValue)
    return goodCount
}