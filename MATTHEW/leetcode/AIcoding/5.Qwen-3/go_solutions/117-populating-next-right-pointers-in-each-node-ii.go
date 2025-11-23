package main

type Node struct {
	Val   int
	Left  *Node
	Right *Node
	Next  *Node
}

func connect(root *Node) *Node {
	if root == nil {
		return nil
	}

	current := root

	for current != nil {
		var nextLevel *Node
		var prev *Node

		for current != nil {
			if current.Left != nil {
				if prev != nil {
					prev.Next = current.Left
				} else {
					nextLevel = current.Left
				}
				prev = current.Left
			}

			if current.Right != nil {
				if prev != nil {
					prev.Next = current.Right
				} else {
					nextLevel = current.Right
				}
				prev = current.Right
			}

			current = current.Next
		}

		current = nextLevel
	}

	return root
}