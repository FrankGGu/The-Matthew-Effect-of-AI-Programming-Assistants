package main

import "fmt"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func findDuplicateSubtrees(root *TreeNode) []*TreeNode {
    memo := make(map[string]int)
    res := []*TreeNode{}
    serialize(root, memo, &res)
    return res
}

func serialize(node *TreeNode, memo map[string]int, res *[]*TreeNode) string {
    if node == nil {
        return "#"
    }
    serial := fmt.Sprintf("%d,%s,%s", node.Val, serialize(node.Left, memo, res), serialize(node.Right, memo, res))
    if count, ok := memo[serial]; ok && count == 1 {
        *res = append(*res, node)
    }
    memo[serial]++
    return serial
}