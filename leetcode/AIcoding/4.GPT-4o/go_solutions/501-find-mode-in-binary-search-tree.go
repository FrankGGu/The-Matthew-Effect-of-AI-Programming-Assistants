package main

import "sort"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

var countMap map[int]int
var maxCount int

func findMode(root *TreeNode) []int {
    countMap = make(map[int]int)
    maxCount = 0
    inorder(root)

    modes := []int{}
    for val, count := range countMap {
        if count == maxCount {
            modes = append(modes, val)
        }
    }

    sort.Ints(modes)
    return modes
}

func inorder(node *TreeNode) {
    if node == nil {
        return
    }
    inorder(node.Left)
    countMap[node.Val]++
    if countMap[node.Val] > maxCount {
        maxCount = countMap[node.Val]
    }
    inorder(node.Right)
}