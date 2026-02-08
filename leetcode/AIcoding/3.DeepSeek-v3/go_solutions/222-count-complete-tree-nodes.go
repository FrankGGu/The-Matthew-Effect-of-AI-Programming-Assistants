/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func countNodes(root *TreeNode) int {
    if root == nil {
        return 0
    }
    leftHeight := getHeight(root.Left)
    rightHeight := getHeight(root.Right)

    if leftHeight == rightHeight {
        return (1 << leftHeight) + countNodes(root.Right)
    } else {
        return (1 << rightHeight) + countNodes(root.Left)
    }
}

func getHeight(node *TreeNode) int {
    height := 0
    for node != nil {
        height++
        node = node.Left
    }
    return height
}