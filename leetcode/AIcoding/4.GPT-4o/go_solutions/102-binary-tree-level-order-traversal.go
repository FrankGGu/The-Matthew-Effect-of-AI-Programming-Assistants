package main

import "container/list"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func levelOrder(root *TreeNode) [][]int {
    if root == nil {
        return [][]int{}
    }

    result := [][]int{}
    queue := list.New()
    queue.PushBack(root)

    for queue.Len() > 0 {
        levelSize := queue.Len()
        level := []int{}

        for i := 0; i < levelSize; i++ {
            node := queue.Remove(queue.Front()).(*TreeNode)
            level = append(level, node.Val)
            if node.Left != nil {
                queue.PushBack(node.Left)
            }
            if node.Right != nil {
                queue.PushBack(node.Right)
            }
        }
        result = append(result, level)
    }

    return result
}