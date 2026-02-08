/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func maxLevelSum(root *TreeNode) int {
    if root == nil {
        return 0
    }

    maxSum := root.Val
    maxLevel := 1
    level := 1

    queue := []*TreeNode{root}

    for len(queue) > 0 {
        levelSize := len(queue)
        currentSum := 0

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            currentSum += node.Val

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }

        if currentSum > maxSum {
            maxSum = currentSum
            maxLevel = level
        }
        level++
    }

    return maxLevel
}