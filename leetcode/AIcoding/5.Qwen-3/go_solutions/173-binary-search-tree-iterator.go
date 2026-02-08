package main

type BSTIterator struct {
	stack []*TreeNode
}

func Constructor(root *TreeNode) BSTIterator {
	iterator := BSTIterator{}
	for root != nil {
		iterator.stack = append(iterator.stack, root)
		root = root.Left
	}
	return iterator
}

func (this *BSTIterator) Next() int {
	node := this.stack[len(this.stack)-1]
	this.stack = this.stack[:len(this.stack)-1]
	current := node.Right
	for current != nil {
		this.stack = append(this.stack, current)
		current = current.Left
	}
	return node.Val
}

func (this *BSTIterator) HasNext() bool {
	return len(this.stack) > 0
}