/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func decorateRecord(root *TreeNode) [][]int {
    if root == nil {
        return [][]int{}
    }
    res := [][]int{}
    queue := []*TreeNode{root}
    level := 0
    for len(queue) > 0 {
        size := len(queue)
        currentLevel := make([]int, size)
        for i := 0; i < size; i++ {
            node := queue[i]
            if level % 2 == 0 {
                currentLevel[i] = node.Val
            } else {
                currentLevel[size - 1 - i] = node.Val
            }
            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        res = append(res, currentLevel)
        queue = queue[size:]
        level++
    }
    return res
}