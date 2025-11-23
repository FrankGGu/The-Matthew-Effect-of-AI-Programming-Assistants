package main

import "math"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func findBottomLeftValue(root *TreeNode) int {
    var result int
    maxDepth := -1

    var dfs func(node *TreeNode, depth int)
    dfs = func(node *TreeNode, depth int) {
        if node == nil {
            return
        }
        if depth > maxDepth {
            maxDepth = depth
            result = node.Val
        }
        dfs(node.Left, depth+1)
        dfs(node.Right, depth+1)
    }

    dfs(root, 0)
    return result
}