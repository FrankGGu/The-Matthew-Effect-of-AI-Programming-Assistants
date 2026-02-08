/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func reverseOddLevels(root *TreeNode) *TreeNode {
    if root == nil {
        return nil
    }

    queue := []*TreeNode{root}
    level := 0

    for len(queue) > 0 {
        n := len(queue)
        if level%2 == 1 {
            values := make([]int, n)
            for i := 0; i < n; i++ {
                values[i] = queue[i].Val
            }
            for i := 0; i < n; i++ {
                queue[i].Val = values[n-1-i]
            }
        }
        for i := 0; i < n; i++ {
            node := queue[i]
            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        queue = queue[n:]
        level++
    }
    return root
}