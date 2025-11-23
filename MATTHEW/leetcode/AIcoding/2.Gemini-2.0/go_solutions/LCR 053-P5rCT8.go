type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func inorderSuccessor(root *TreeNode, p *TreeNode) *TreeNode {
	var successor *TreeNode
	for root != nil {
		if p.Val >= root.Val {
			root = root.Right
		} else {
			successor = root
			root = root.Left
		}
	}
	return successor
}