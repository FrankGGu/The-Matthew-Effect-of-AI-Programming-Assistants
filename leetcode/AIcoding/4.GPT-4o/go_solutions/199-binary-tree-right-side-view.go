package main

import "container/list"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func rightSideView(root *TreeNode) []int {
    if root == nil {
        return []int{}
    }
    result := []int{}
    queue := list.New()
    queue.PushBack(root)

    for queue.Len() > 0 {
        size := queue.Len()
        for i := 0; i < size; i++ {
            node := queue.Remove(queue.Front()).(*TreeNode)
            if i == size-1 {
                result = append(result, node.Val)
            }
            if node.Left != nil {
                queue.PushBack(node.Left)
            }
            if node.Right != nil {
                queue.PushBack(node.Right)
            }
        }
    }
    return result
}