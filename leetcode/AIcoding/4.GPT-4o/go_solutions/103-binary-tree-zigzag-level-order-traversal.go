package main

import "container/list"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func zigzagLevelOrder(root *TreeNode) [][]int {
    if root == nil {
        return [][]int{}
    }

    result := [][]int{}
    queue := list.New()
    queue.PushBack(root)
    leftToRight := true

    for queue.Len() > 0 {
        levelSize := queue.Len()
        level := make([]int, levelSize)

        for i := 0; i < levelSize; i++ {
            node := queue.Remove(queue.Front()).(*TreeNode)
            if leftToRight {
                level[i] = node.Val
            } else {
                level[levelSize-i-1] = node.Val
            }
            if node.Left != nil {
                queue.PushBack(node.Left)
            }
            if node.Right != nil {
                queue.PushBack(node.Right)
            }
        }

        result = append(result, level)
        leftToRight = !leftToRight
    }

    return result
}