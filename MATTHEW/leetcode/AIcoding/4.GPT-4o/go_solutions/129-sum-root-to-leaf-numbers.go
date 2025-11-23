package main

import "strconv"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func sumNumbers(root *TreeNode) int {
    return sum(root, 0)
}

func sum(node *TreeNode, current int) int {
    if node == nil {
        return 0
    }
    current = current*10 + node.Val
    if node.Left == nil && node.Right == nil {
        return current
    }
    return sum(node.Left, current) + sum(node.Right, current)
}