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
    stack := []*TreeNode{}
    node := root

    for node != nil || len(stack) > 0 {
        for node != nil {
            stack = append(stack, node)
            node = node.Left
        }
        node = stack[len(stack)-1]
        stack = stack[:len(stack)-1]

        current.Right = &TreeNode{Val: node.Val}
        current = current.Right

        node = node.Right
    }

    return dummy.Right
}