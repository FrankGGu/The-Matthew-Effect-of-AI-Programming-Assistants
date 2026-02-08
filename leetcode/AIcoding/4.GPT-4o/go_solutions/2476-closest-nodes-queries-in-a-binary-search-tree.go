package main

import "sort"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

type BST struct {
    values []int
}

func (bst *BST) insert(node *TreeNode) {
    if node == nil {
        return
    }
    bst.values = append(bst.values, node.Val)
    bst.insert(node.Left)
    bst.insert(node.Right)
}

func closestNodes(root *TreeNode, queries []int) [][]int {
    bst := &BST{}
    bst.insert(root)
    sort.Ints(bst.values)

    result := make([][]int, len(queries))
    for i, query := range queries {
        idx := sort.SearchInts(bst.values, query)
        if idx < len(bst.values) && bst.values[idx] == query {
            result[i] = []int{query, query}
        } else {
            left := -1
            right := -1
            if idx > 0 {
                left = bst.values[idx-1]
            }
            if idx < len(bst.values) {
                right = bst.values[idx]
            }
            result[i] = []int{left, right}
        }
    }
    return result
}