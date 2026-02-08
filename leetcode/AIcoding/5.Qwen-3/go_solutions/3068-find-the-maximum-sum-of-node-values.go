package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func maxSumUtil(node *TreeNode, parent *TreeNode, grandParent *TreeNode, sum *int) {
	if node == nil {
		return
	}
	if grandParent != nil {
		*sum += node.Val
	}
	maxSumUtil(node.Left, node, parent, sum)
	maxSumUtil(node.Right, node, parent, sum)
}

func maxSum(root *TreeNode) int {
	if root == nil {
		return 0
	}
	sum := 0
	maxSumUtil(root, nil, nil, &sum)
	return sum
}