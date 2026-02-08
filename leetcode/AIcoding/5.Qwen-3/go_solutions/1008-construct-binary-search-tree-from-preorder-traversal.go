package main


func bstFromPreorder(preorder []int) *TreeNode {
	if len(preorder) == 0 {
		return nil
	}
	return buildBST(preorder, 0, len(preorder)-1)
}

func buildBST(preorder []int, left, right int) *TreeNode {
	if left > right {
		return nil
	}
	root := &TreeNode{Val: preorder[left]}
	i := left + 1
	for i <= right && preorder[i] < root.Val {
		i++
	}
	root.Left = buildBST(preorder, left+1, i-1)
	root.Right = buildBST(preorder, i, right)
	return root
}