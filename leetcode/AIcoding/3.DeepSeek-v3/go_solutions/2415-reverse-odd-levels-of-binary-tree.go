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
        size := len(queue)
        currentLevel := make([]*TreeNode, 0)
        values := make([]int, 0)

        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]
            currentLevel = append(currentLevel, node)
            values = append(values, node.Val)

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }

        if level % 2 == 1 {
            for i := 0; i < len(currentLevel); i++ {
                currentLevel[i].Val = values[len(values)-1-i]
            }
        }
        level++
    }

    return root
}