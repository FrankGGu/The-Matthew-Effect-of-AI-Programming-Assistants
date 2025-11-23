/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func decorateRecord(root *TreeNode) []int {
    if root == nil {
        return []int{}
    }
    queue := []*TreeNode{root}
    res := []int{}
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        res = append(res, node.Val)
        if node.Left != nil {
            queue = append(queue, node.Left)
        }
        if node.Right != nil {
            queue = append(queue, node.Right)
        }
    }
    return res
}