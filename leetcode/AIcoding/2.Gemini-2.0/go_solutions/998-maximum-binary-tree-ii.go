type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func insertIntoMaxTree(root *TreeNode, val int) *TreeNode {
	if root == nil {
		return &TreeNode{Val: val}
	}

	if val > root.Val {
		newNode := &TreeNode{Val: val, Left: root}
		return newNode
	}

	root.Right = insertIntoMaxTree(root.Right, val)
	return root
}