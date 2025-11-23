type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func constructFromPrePost(preorder []int, postorder []int) *TreeNode {
	if len(preorder) == 0 {
		return nil
	}

	root := &TreeNode{Val: preorder[0]}

	if len(preorder) == 1 {
		return root
	}

	leftRootVal := preorder[1]
	leftSize := 0
	for i := 0; i < len(postorder); i++ {
		if postorder[i] == leftRootVal {
			leftSize = i + 1
			break
		}
	}

	root.Left = constructFromPrePost(preorder[1:leftSize+1], postorder[:leftSize])
	root.Right = constructFromPrePost(preorder[leftSize+1:], postorder[leftSize:len(postorder)-1])

	return root
}