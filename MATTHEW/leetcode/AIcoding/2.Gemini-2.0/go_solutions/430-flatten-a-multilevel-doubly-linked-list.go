func flatten(root *Node) *Node {
	if root == nil {
		return nil
	}

	curr := root
	for curr != nil {
		if curr.Child != nil {
			next := curr.Next
			child := curr.Child

			curr.Next = child
			child.Prev = curr

			tail := child
			for tail.Next != nil {
				tail = tail.Next
			}

			if next != nil {
				tail.Next = next
				next.Prev = tail
			}

			curr.Child = nil
		}
		curr = curr.Next
	}

	return root
}