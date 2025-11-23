package main

type Node struct {
	Val int
	Prev *Node
	Next *Node
	Child *Node
}

func flatten(head *Node) *Node {
	if head == nil {
		return nil
	}

	var stack []*Node
	stack = append(stack, head)

	var prev *Node

	for len(stack) > 0 {
		curr := stack[len(stack)-1]
		stack = stack[:len(stack)-1]

		if prev != nil {
			prev.Next = curr
			curr.Prev = prev
		}

		prev = curr

		if curr.Next != nil {
			stack = append(stack, curr.Next)
		}

		if curr.Child != nil {
			stack = append(stack, curr.Child)
			curr.Child = nil
		}
	}

	return head
}