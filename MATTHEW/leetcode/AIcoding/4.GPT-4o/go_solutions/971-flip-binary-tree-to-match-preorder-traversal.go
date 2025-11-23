package main

/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func flipMatchVoyage(root *TreeNode, voyage []int) []int {
    var res []int
    var idx int

    var dfs func(node *TreeNode) bool
    dfs = func(node *TreeNode) bool {
        if node == nil {
            return true
        }
        if idx >= len(voyage) || node.Val != voyage[idx] {
            return false
        }
        idx++
        if node.Left != nil && idx < len(voyage) && node.Left.Val != voyage[idx] {
            res = append(res, node.Val)
            return dfs(node.Right) && dfs(node.Left)
        }
        return dfs(node.Left) && dfs(node.Right)
    }

    if dfs(root) {
        return res
    }
    return []int{-1}
}