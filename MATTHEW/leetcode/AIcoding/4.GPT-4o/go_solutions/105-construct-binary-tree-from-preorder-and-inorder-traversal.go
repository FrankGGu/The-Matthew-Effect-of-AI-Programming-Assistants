package main

import "fmt"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func buildTree(preorder []int, inorder []int) *TreeNode {
    if len(preorder) == 0 || len(inorder) == 0 {
        return nil
    }
    rootVal := preorder[0]
    root := &TreeNode{Val: rootVal}
    index := 0
    for i, v := range inorder {
        if v == rootVal {
            index = i
            break
        }
    }
    root.Left = buildTree(preorder[1:index+1], inorder[:index])
    root.Right = buildTree(preorder[index+1:], inorder[index+1:])
    return root
}