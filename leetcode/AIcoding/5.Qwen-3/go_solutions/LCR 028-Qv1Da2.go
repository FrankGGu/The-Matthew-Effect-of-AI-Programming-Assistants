package main

type Node struct {
	Val   int
	Prev  *Node
	next  *Node
	Child *Node
}

func flatten(head *Node) *Node {
	if head == nil {
		return nil
	}

	current := head

	for current != nil {
		if current.Child != nil {
			nextNode := current.next
			child := current.Child

			current.next = child
			child.Prev = current
			current.Child = nil

			tail := child
			for tail.next != nil {
				tail = tail.next
			}

			tail.next = nextNode
			if nextNode != nil {
				nextNode.Prev = tail
			}
		}

		current = current.next
	}

	return head
}