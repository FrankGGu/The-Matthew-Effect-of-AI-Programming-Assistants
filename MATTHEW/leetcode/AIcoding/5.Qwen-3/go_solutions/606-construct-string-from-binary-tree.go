package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func treeToString(root *TreeNode) string {
	if root == nil {
		return ""
	}
	if root.Left == nil && root.Right == nil {
		return strconv.Itoa(root.Val)
	}
	if root.Right == nil {
		return strconv.Itoa(root.Val) + "(" + treeToString(root.Left) + ")"
	}
	return strconv.Itoa(root.Val) + "(" + treeToString(root.Left) + ")" + "(" + treeToString(root.Right) + ")"
}