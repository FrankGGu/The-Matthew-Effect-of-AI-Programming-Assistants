/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func pathSum(root *TreeNode, sum int) int {
    if root == nil {
        return 0
    }
    return countPaths(root, sum) + pathSum(root.Left, sum) + pathSum(root.Right, sum)
}

func countPaths(node *TreeNode, sum int) int {
    if node == nil {
        return 0
    }
    count := 0
    if node.Val == sum {
        count++
    }
    count += countPaths(node.Left, sum-node.Val)
    count += countPaths(node.Right, sum-node.Val)
    return count
}