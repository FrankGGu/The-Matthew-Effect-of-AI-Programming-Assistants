package main

import "fmt"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

var memo = make(map[string]int)
var result []*TreeNode

func findDuplicateSubtrees(root *TreeNode) []*TreeNode {
    memo = make(map[string]int)
    result = []*TreeNode{}
    serialize(root)
    return result
}

func serialize(node *TreeNode) string {
    if node == nil {
        return "#"
    }
    serial := fmt.Sprintf("%d,%s,%s", node.Val, serialize(node.Left), serialize(node.Right))
    memo[serial]++
    if memo[serial] == 2 {
        result = append(result, node)
    }
    return serial
}