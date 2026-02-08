package main

import "fmt"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func increasingBST(root *TreeNode) *TreeNode {
    var ans, prev *TreeNode
    var inorder func(node *TreeNode)

    inorder = func(node *TreeNode) {
        if node == nil {
            return
        }
        inorder(node.Left)
        if ans == nil {
            ans = &TreeNode{Val: node.Val}
            prev = ans
        } else {
            prev.Right = &TreeNode{Val: node.Val}
            prev = prev.Right
        }
        inorder(node.Right)
    }

    inorder(root)
    return ans
}