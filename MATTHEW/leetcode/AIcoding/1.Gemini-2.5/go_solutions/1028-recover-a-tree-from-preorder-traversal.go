package main

import (
	"strconv"
)

type TreeNode struct {
    Val int
    Left *TreeNode
    Right *TreeNode
}

var s string
var idx int

func recoverFromPreorder(S string) *TreeNode {
    s = S
    idx = 0
    return dfs(0)
}

func dfs(currentDepth int) *TreeNode {
    if idx >= len(s) {
        return nil
    }

    tempIdx := idx
    dashes := 0
    for tempIdx < len(s) && s[tempIdx] == '-' {
        dashes++
        tempIdx++
    }

    if dashes != currentDepth {
        return nil
    }

    startValIdx := tempIdx
    for tempIdx < len(s) && s[tempIdx] != '-' {
        tempIdx++
    }
    valStr := s[startValIdx:tempIdx]
    val, _ := strconv.Atoi(valStr)

    idx = tempIdx

    node := &TreeNode{Val: val}
    node.Left = dfs(currentDepth + 1)
    node.Right = dfs(currentDepth + 1)

    return node
}