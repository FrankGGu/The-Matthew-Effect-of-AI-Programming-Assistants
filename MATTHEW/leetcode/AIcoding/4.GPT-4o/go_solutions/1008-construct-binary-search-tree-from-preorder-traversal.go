package main

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func bstFromPreorder(preorder []int) *TreeNode {
    if len(preorder) == 0 {
        return nil
    }
    return constructTree(preorder, 0, len(preorder)-1)
}

func constructTree(preorder []int, start, end int) *TreeNode {
    if start > end {
        return nil
    }
    root := &TreeNode{Val: preorder[start]}
    rightStart := start + 1
    for rightStart <= end && preorder[rightStart] < root.Val {
        rightStart++
    }
    root.Left = constructTree(preorder, start+1, rightStart-1)
    root.Right = constructTree(preorder, rightStart, end)
    return root
}