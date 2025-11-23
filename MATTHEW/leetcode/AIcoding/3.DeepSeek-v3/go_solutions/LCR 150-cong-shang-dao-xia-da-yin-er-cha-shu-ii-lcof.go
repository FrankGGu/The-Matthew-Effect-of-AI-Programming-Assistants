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
    leftToRight := true
    for len(queue) > 0 {
        levelSize := len(queue)
        level := make([]int, levelSize)
        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            index := i
            if !leftToRight {
                index = levelSize - 1 - i
            }
            level[index] = node.Val
            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        res = append(res, level)
        leftToRight = !leftToRight
    }
    return res
}