package main

import "leetcode/utils"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func hasPathSum(root *TreeNode, sum int) bool {
    if root == nil {
        return sum == 0
    }
    sum -= root.Val
    if root.Left == nil && root.Right == nil {
        return sum == 0
    }
    return hasPathSum(root.Left, sum) || hasPathSum(root.Right, sum)
}