package main

type TreeNode struct {
	Val   int
	left  *TreeNode
	right *TreeNode
}

func createBinaryTree(descriptions [][]int) *TreeNode {
	nodes := make(map[int]*TreeNode)
	connections := make(map[int]map[string]int)

	for _, desc := range descriptions {
		parentVal, childVal, isLeft := desc[0], desc[1], desc[2]
		if _, exists := nodes[parentVal]; !exists {
			nodes[parentVal] = &TreeNode{Val: parentVal}
		}
		if _, exists := nodes[childVal]; !exists {
			nodes[childVal] = &TreeNode{Val: childVal}
		}

		if _, exists := connections[parentVal]; !exists {
			connections[parentVal] = make(map[string]int)
		}

		if isLeft == 1 {
			connections[parentVal]["left"] = childVal
		} else {
			connections[parentVal]["right"] = childVal
		}
	}

	for _, node := range nodes {
		if _, exists := connections[node.Val]; exists {
			if leftChild, ok := connections[node.Val]["left"]; ok {
				node.left = nodes[leftChild]
			}
			if rightChild, ok := connections[node.Val]["right"]; ok {
				node.right = nodes[rightChild]
			}
		}
	}

	for _, node := range nodes {
		found := false
		for _, n := range nodes {
			if n != node {
				if (n.left != nil && n.left.Val == node.Val) || (n.right != nil && n.right.Val == node.Val) {
					found = true
					break
				}
			}
		}
		if !found {
			return node
		}
	}

	return nil
}