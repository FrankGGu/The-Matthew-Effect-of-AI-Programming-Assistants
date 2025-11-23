/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func isEvenOddTree(root *TreeNode) bool {
    if root == nil {
        return true
    }

    queue := []*TreeNode{root}
    level := 0

    for len(queue) > 0 {
        size := len(queue)
        prev := 0

        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]

            if level % 2 == 0 {
                if node.Val % 2 == 0 {
                    return false
                }
                if i > 0 && node.Val <= prev {
                    return false
                }
            } else {
                if node.Val % 2 != 0 {
                    return false
                }
                if i > 0 && node.Val >= prev {
                    return false
                }
            }
            prev = node.Val

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        level++
    }
    return true
}