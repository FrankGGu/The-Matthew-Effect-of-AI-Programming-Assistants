package main

import (
    "container/list"
    "math"
)

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func minimumOperations(root *TreeNode) int {
    if root == nil {
        return 0
    }

    var queue = list.New()
    queue.PushBack(root)
    operations := 0

    for queue.Len() > 0 {
        size := queue.Len()
        level := make([]int, size)
        for i := 0; i < size; i++ {
            node := queue.Remove(queue.Front()).(*TreeNode)
            level[i] = node.Val
            if node.Left != nil {
                queue.PushBack(node.Left)
            }
            if node.Right != nil {
                queue.PushBack(node.Right)
            }
        }

        sorted := make([]int, size)
        copy(sorted, level)
        sort.Ints(sorted)

        indexMap := make(map[int][]int)
        for i, v := range level {
            indexMap[v] = append(indexMap[v], i)
        }

        seen := make([]bool, size)
        cycles := 0

        for i := 0; i < size; i++ {
            if seen[i] || level[i] == sorted[i] {
                continue
            }

            cycles++
            j := i
            for !seen[j] {
                seen[j] = true
                j = indexMap[sorted[j]][0]
                indexMap[sorted[j]] = indexMap[sorted[j]][1:]
            }
        }

        operations += size - cycles;
    }

    return operations
}