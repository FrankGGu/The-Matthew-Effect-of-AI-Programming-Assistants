package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func validateBinaryTreeNodes(root int, leftChild []int, rightChild []int) bool {
	n := len(leftChild)
	visited := make([]bool, n)
	inDegree := make([]int, n)

	for i := 0; i < n; i++ {
		if leftChild[i] != -1 {
			inDegree[leftChild[i]]++
		}
		if rightChild[i] != -1 {
			inDegree[rightChild[i]]++
		}
	}

	if inDegree[root] != 0 {
		return false
	}

	queue := []*TreeNode{{Val: root}}
	visited[root] = true

	for len(queue) > 0 {
		node := queue[0]
		queue = queue[1:]

		left := leftChild[node.Val]
		right := rightChild[node.Val]

		if left != -1 {
			if visited[left] {
				return false
			}
			visited[left] = true
			queue = append(queue, &TreeNode{Val: left})
		}

		if right != -1 {
			if visited[right] {
				return false
			}
			visited[right] = true
			queue = append(queue, &TreeNode{Val: right})
		}
	}

	for _, v := range visited {
		if !v {
			return false
		}
	}

	return true
}