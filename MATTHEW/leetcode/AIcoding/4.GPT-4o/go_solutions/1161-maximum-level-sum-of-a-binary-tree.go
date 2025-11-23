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

    queue := []*TreeNode{root}
    maxSum := root.Val
    maxLevel := 1
    currentLevel := 1
    for len(queue) > 0 {
        levelSum := 0
        levelSize := len(queue)
        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            levelSum += node.Val
            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        if levelSum > maxSum {
            maxSum = levelSum
            maxLevel = currentLevel
        }
        currentLevel++
    }
    return maxLevel
}