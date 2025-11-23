type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func btreeGameWinningMove(root *TreeNode, n int, x int) bool {
	var left, right int
	find := func(node *TreeNode, target int) *TreeNode {
		if node == nil {
			return nil
		}
		if node.Val == target {
			return node
		}
		l := find(node.Left, target)
		if l != nil {
			return l
		}
		return find(node.Right, target)
	}

	xNode := find(root, x)

	count := func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		return 1 + count(node.Left) + count(node.Right)
	}

	if xNode.Left != nil {
		left = count(xNode.Left)
	}
	if xNode.Right != nil {
		right = count(xNode.Right)
	}

	parent := n - 1 - left - right

	return left > parent+right || right > parent+left || parent > left+right
}