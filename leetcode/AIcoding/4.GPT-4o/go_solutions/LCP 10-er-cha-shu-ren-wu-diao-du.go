package main

import "sort"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func minimumTime(root *TreeNode) int {
    if root == nil {
        return 0
    }
    times := []int{}
    dfs(root, 0, &times)
    sort.Ints(times)
    totalTime := 0
    for i, t := range times {
        totalTime = max(totalTime, t+i+1)
    }
    return totalTime
}

func dfs(node *TreeNode, time int, times *[]int) {
    if node == nil {
        return
    }
    dfs(node.Left, time+1, times)
    *times = append(*times, time)
    dfs(node.Right, time+1, times)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}