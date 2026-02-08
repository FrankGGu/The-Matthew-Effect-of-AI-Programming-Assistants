type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func buildTree(inorder []int, postorder []int) *TreeNode {
	if len(inorder) == 0 {
		return nil
	}

	rootVal := postorder[len(postorder)-1]
	root := &TreeNode{Val: rootVal}

	var inorderRootIndex int
	for i, val := range inorder {
		if val == rootVal {
			inorderRootIndex = i
			break
		}
	}

	root.Left = buildTree(inorder[:inorderRootIndex], postorder[:inorderRootIndex])
	root.Right = buildTree(inorder[inorderRootIndex+1:], postorder[inorderRootIndex:len(postorder)-1])

	return root
}