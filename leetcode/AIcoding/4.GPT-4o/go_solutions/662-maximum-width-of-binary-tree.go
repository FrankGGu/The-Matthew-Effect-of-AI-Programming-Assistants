package main

import "math"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func widthOfBinaryTree(root *TreeNode) int {
    if root == nil {
        return 0
    }
    maxWidth := 0
    queue := []*TreeNode{root}
    indices := []int{0}

    for len(queue) > 0 {
        size := len(queue)
        left := indices[0]
        right := indices[size-1]
        maxWidth = int(math.Max(float64(maxWidth), float64(right-left+1)))

        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]
            if node.Left != nil {
                queue = append(queue, node.Left)
                indices = append(indices, 2*indices[i]+1)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
                indices = append(indices, 2*indices[i]+2)
            }
        }
        indices = indices[size:]
    }
    return maxWidth
}