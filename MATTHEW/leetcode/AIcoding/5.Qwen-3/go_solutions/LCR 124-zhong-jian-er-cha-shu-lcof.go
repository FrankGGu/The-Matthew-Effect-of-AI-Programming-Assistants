package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func buildTree(preorder []int, inorder []int) *TreeNode {
	if len(preorder) == 0 {
		return nil
	}
	root := &TreeNode{Val: preorder[0]}
	var index int
	for i := 0; i < len(inorder); i++ {
		if inorder[i] == root.Val {
			index = i
			break
		}
	}
	root.Left = buildTree(preorder[1:1+index], inorder[:index])
	root.Right = buildTree(preorder[1+index:], inorder[index+1:])
	return root
}