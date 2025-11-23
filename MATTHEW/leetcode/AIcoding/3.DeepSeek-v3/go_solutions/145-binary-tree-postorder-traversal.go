/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func postorderTraversal(root *TreeNode) []int {
    var result []int
    var stack []*TreeNode
    var lastVisited *TreeNode

    for root != nil || len(stack) > 0 {
        for root != nil {
            stack = append(stack, root)
            root = root.Left
        }

        node := stack[len(stack)-1]
        if node.Right == nil || node.Right == lastVisited {
            stack = stack[:len(stack)-1]
            result = append(result, node.Val)
            lastVisited = node
        } else {
            root = node.Right
        }
    }

    return result
}