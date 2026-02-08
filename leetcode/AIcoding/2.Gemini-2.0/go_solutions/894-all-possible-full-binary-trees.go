func allPossibleFBT(n int) []*TreeNode {
	if n%2 == 0 {
		return []*TreeNode{}
	}
	if n == 1 {
		return []*TreeNode{&TreeNode{Val: 0}}
	}
	res := []*TreeNode{}
	for i := 1; i < n; i += 2 {
		left := allPossibleFBT(i)
		right := allPossibleFBT(n - i - 1)
		for _, l := range left {
			for _, r := range right {
				root := &TreeNode{Val: 0}
				root.Left = l
				root.Right = r
				res = append(res, root)
			}
		}
	}
	return res
}