package main

import "fmt"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func countPairs(root *TreeNode, distance int) int {
    count := 0
    var dfs func(node *TreeNode) []int
    dfs = func(node *TreeNode) []int {
        if node == nil {
            return nil
        }
        if node.Left == nil && node.Right == nil {
            return []int{1}
        }
        leftDistances := dfs(node.Left)
        rightDistances := dfs(node.Right)
        for _, l := range leftDistances {
            for _, r := range rightDistances {
                if l+r <= distance {
                    count++
                }
            }
        }
        distances := make([]int, 0)
        for _, l := range leftDistances {
            if l < distance {
                distances = append(distances, l+1)
            }
        }
        for _, r := range rightDistances {
            if r < distance {
                distances = append(distances, r+1)
            }
        }
        return distances
    }
    dfs(root)
    return count
}