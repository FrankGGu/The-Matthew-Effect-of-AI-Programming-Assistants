/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func inorderSuccessor(root *TreeNode, p *TreeNode) *TreeNode {
    var successor *TreeNode
    current := root

    for current != nil {
        if current.Val > p.Val {
            successor = current
            current = current.Left
        } else {
            current = current.Right
        }
    }

    return successor
}