type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func bstFromPreorder(preorder []int) *TreeNode {
	idx := 0
	var build func(lower, upper int) *TreeNode
	build = func(lower, upper int) *TreeNode {
		if idx == len(preorder) {
			return nil
		}
		val := preorder[idx]
		if val < lower || val > upper {
			return nil
		}
		idx++
		root := &TreeNode{Val: val}
		root.Left = build(lower, val)
		root.Right = build(val, upper)
		return root
	}
	return build(0, 1001)
}