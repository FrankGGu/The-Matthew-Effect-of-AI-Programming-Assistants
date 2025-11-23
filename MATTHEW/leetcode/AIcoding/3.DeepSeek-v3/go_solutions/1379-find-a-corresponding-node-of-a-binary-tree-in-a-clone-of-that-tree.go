/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func getTargetCopy(original *TreeNode, cloned *TreeNode, target *TreeNode) *TreeNode {
    if original == nil {
        return nil
    }
    if original == target {
        return cloned
    }
    left := getTargetCopy(original.Left, cloned.Left, target)
    if left != nil {
        return left
    }
    return getTargetCopy(original.Right, cloned.Right, target)
}