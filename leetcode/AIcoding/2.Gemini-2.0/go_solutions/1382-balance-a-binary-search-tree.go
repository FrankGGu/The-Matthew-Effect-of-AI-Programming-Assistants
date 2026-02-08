type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func balanceBST(root *TreeNode) *TreeNode {
	nodes := inorder(root)
	return buildBalancedBST(nodes, 0, len(nodes)-1)
}

func inorder(root *TreeNode) []int {
	var result []int
	var inorderHelper func(node *TreeNode)
	inorderHelper = func(node *TreeNode) {
		if node == nil {
			return
		}
		inorderHelper(node.Left)
		result = append(result, node.Val)
		inorderHelper(node.Right)
	}
	inorderHelper(root)
	return result
}

func buildBalancedBST(nodes []int, start int, end int) *TreeNode {
	if start > end {
		return nil
	}
	mid := (start + end) / 2
	root := &TreeNode{Val: nodes[mid]}
	root.Left = buildBalancedBST(nodes, start, mid-1)
	root.Right = buildBalancedBST(nodes, mid+1, end)
	return root
}