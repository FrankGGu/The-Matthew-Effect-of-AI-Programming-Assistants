/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func largestValues(root *TreeNode) []int {
    if root == nil {
        return []int{}
    }

    res := []int{}
    queue := []*TreeNode{root}

    for len(queue) > 0 {
        maxVal := queue[0].Val
        nextQueue := []*TreeNode{}

        for _, node := range queue {
            if node.Val > maxVal {
                maxVal = node.Val
            }
            if node.Left != nil {
                nextQueue = append(nextQueue, node.Left)
            }
            if node.Right != nil {
                nextQueue = append(nextQueue, node.Right)
            }
        }

        res = append(res, maxVal)
        queue = nextQueue
    }

    return res
}