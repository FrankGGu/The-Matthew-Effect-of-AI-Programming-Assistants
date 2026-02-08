package main

import "math"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func findSecondMinimumValue(root *TreeNode) int {
    if root == nil {
        return -1
    }
    secondMin := math.MaxInt64
    var dfs func(node *TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }
        if node.Val > root.Val && node.Val < secondMin {
            secondMin = node.Val
        } else if node.Val == root.Val {
            dfs(node.Left)
            dfs(node.Right)
        }
    }
    dfs(root)
    if secondMin == math.MaxInt64 {
        return -1
    }
    return secondMin
}