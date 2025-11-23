/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func isCompleteTree(root *TreeNode) bool {
    if root == nil {
        return true
    }

    queue := []*TreeNode{root}
    end := false

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]

        if node == nil {
            end = true
        } else {
            if end {
                return false
            }
            queue = append(queue, node.Left, node.Right)
        }
    }

    return true
}