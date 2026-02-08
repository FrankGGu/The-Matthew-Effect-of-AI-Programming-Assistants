package main

import "leetcode/utils"

func buildTree(inorder []int, postorder []int) *utils.TreeNode {
	if len(inorder) == 0 || len(postorder) == 0 {
		return nil
	}

	rootVal := postorder[len(postorder)-1]
	root := &utils.TreeNode{Val: rootVal}

	index := 0
	for i, v := range inorder {
		if v == rootVal {
			index = i
			break
		}
	}

	root.Left = buildTree(inorder[:index], postorder[:index])
	root.Right = buildTree(inorder[index+1:], postorder[index:len(postorder)-1])

	return root
}