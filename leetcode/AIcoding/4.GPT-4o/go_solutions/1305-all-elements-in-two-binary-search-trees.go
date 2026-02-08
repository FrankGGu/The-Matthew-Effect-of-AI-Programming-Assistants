package main

import (
	"container/list"
	"sort"
)

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func getAllElements(root1 *TreeNode, root2 *TreeNode) []int {
	var res []int
	var stack1, stack2 []*TreeNode

	for root1 != nil || root2 != nil || len(stack1) > 0 || len(stack2) > 0 {
		for root1 != nil {
			stack1 = append(stack1, root1)
			root1 = root1.Left
		}
		for root2 != nil {
			stack2 = append(stack2, root2)
			root2 = root2.Left
		}
		if len(stack1) == 0 && len(stack2) == 0 {
			break
		}
		var val1, val2 int
		if len(stack1) > 0 {
			val1 = stack1[len(stack1)-1].Val
		} else {
			val1 = int(^uint(0) >> 1)
		}
		if len(stack2) > 0 {
			val2 = stack2[len(stack2)-1].Val
		} else {
			val2 = int(^uint(0) >> 1)
		}
		if val1 <= val2 {
			res = append(res, val1)
			root1 = stack1[len(stack1)-1].Right
			stack1 = stack1[:len(stack1)-1]
		} else {
			res = append(res, val2)
			root2 = stack2[len(stack2)-1].Right
			stack2 = stack2[:len(stack2)-1]
		}
	}
	return res
}