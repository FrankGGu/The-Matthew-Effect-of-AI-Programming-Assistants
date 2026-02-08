type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func findMode(root *TreeNode) []int {
	var mode []int
	var count int
	var maxCount int
	var prev *int

	var inorder func(node *TreeNode)
	inorder = func(node *TreeNode) {
		if node == nil {
			return
		}

		inorder(node.Left)

		if prev != nil {
			if node.Val == *prev {
				count++
			} else {
				count = 1
			}
		} else {
			count = 1
		}

		if count > maxCount {
			maxCount = count
			mode = []int{node.Val}
		} else if count == maxCount {
			mode = append(mode, node.Val)
		}

		prevVal := node.Val
		prev = &prevVal

		inorder(node.Right)
	}

	inorder(root)
	return mode
}