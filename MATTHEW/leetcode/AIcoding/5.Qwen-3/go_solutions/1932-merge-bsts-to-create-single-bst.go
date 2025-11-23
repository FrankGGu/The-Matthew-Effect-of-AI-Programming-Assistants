package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func mergeBsts(bsts []*TreeNode) *TreeNode {
	var result *TreeNode
	for _, bst := range bsts {
		result = merge(result, bst)
	}
	return result
}

func merge(a, b *TreeNode) *TreeNode {
	if a == nil {
		return b
	}
	if b == nil {
		return a
	}
	if a.Val < b.Val {
		a.Right = merge(a.Right, b)
		return a
	} else {
		b.Right = merge(a, b.Right)
		return b
	}
}