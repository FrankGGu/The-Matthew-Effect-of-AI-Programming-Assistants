/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func increasingBST(root *TreeNode) *TreeNode {
    dummy := &TreeNode{}
    current := dummy
    var inorder func(*TreeNode)
    inorder = func(node *TreeNode) {
        if node == nil {
            return
        }
        inorder(node.Left)
        node.Left = nil
        current.Right = node
        current = node
        inorder(node.Right)
    }
    inorder(root)
    return dummy.Right
}