/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func recoverTree(root *TreeNode)  {
    var first, second, prev *TreeNode
    var stack []*TreeNode
    current := root

    for current != nil || len(stack) > 0 {
        for current != nil {
            stack = append(stack, current)
            current = current.Left
        }
        current = stack[len(stack)-1]
        stack = stack[:len(stack)-1]

        if prev != nil && prev.Val > current.Val {
            if first == nil {
                first = prev
            }
            second = current
        }
        prev = current
        current = current.Right
    }

    first.Val, second.Val = second.Val, first.Val
}