package main

import (
    "sort"
)

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func mergeTrees(trees []*TreeNode) *TreeNode {
    var vals []int
    for _, tree := range trees {
        inorder(tree, &vals)
    }
    sort.Ints(vals)
    return buildBST(vals, 0, len(vals)-1)
}

func inorder(node *TreeNode, vals *[]int) {
    if node == nil {
        return
    }
    inorder(node.Left, vals)
    *vals = append(*vals, node.Val)
    inorder(node.Right, vals)
}

func buildBST(vals []int, start, end int) *TreeNode {
    if start > end {
        return nil
    }
    mid := (start + end) / 2
    root := &TreeNode{Val: vals[mid]}
    root.Left = buildBST(vals, start, mid-1)
    root.Right = buildBST(vals, mid+1, end)
    return root
}