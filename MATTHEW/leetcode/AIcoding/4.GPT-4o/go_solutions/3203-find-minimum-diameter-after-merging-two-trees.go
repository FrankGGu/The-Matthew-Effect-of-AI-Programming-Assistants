package main

import "math"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func findMinimumDiameter(root1 *TreeNode, root2 *TreeNode, m int) int {
    if root1 == nil && root2 == nil {
        return 0
    }
    mergedRoot := mergeTrees(root1, root2)
    return calculateDiameter(mergedRoot) - m
}

func mergeTrees(t1 *TreeNode, t2 *TreeNode) *TreeNode {
    if t1 == nil {
        return t2
    }
    if t2 == nil {
        return t1
    }
    return &TreeNode{
        Val:   t1.Val + t2.Val,
        Left:  mergeTrees(t1.Left, t2.Left),
        Right: mergeTrees(t1.Right, t2.Right),
    }
}

func calculateDiameter(root *TreeNode) int {
    diameter := 0
    depth(root, &diameter)
    return diameter
}

func depth(node *TreeNode, diameter *int) int {
    if node == nil {
        return 0
    }
    leftDepth := depth(node.Left, diameter)
    rightDepth := depth(node.Right, diameter)
    *diameter = int(math.Max(float64(*diameter), float64(leftDepth+rightDepth)))
    return 1 + int(math.Max(float64(leftDepth), float64(rightDepth)))
}