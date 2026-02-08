package main

import "fmt"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func minEdgeWeightEquilibriumQueries(root *TreeNode, queries []int) []int {
    result := make([]int, len(queries))
    edgeWeights := make(map[int]int)

    var dfs func(node *TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        leftSum := dfs(node.Left)
        rightSum := dfs(node.Right)
        edgeWeights[node.Val] = leftSum + rightSum + node.Val
        return leftSum + rightSum + node.Val
    }

    dfs(root)

    for i, query := range queries {
        result[i] = edgeWeights[query]
    }

    return result
}

func main() {
    // Example usage:
    root := &TreeNode{Val: 1, Left: &TreeNode{Val: 2}, Right: &TreeNode{Val: 3}}
    queries := []int{1, 2, 3}
    fmt.Println(minEdgeWeightEquilibriumQueries(root, queries))
}