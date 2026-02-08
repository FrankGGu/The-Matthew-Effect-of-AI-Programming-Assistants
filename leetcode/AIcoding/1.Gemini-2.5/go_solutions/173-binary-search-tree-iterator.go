type BSTIterator struct {
    stack []*TreeNode
}

func Constructor(root *TreeNode) BSTIterator {
    iterator := BSTIterator{
        stack: make([]*TreeNode, 0),
    }
    curr := root
    for curr != nil {
        iterator.stack = append(iterator.stack, curr)
        curr = curr.Left
    }
    return iterator
}

func (this *BSTIterator) Next() int {
    n := len(this.stack)
    node := this.stack[n-1]
    this.stack = this.stack[:n-1]

    curr := node.Right
    for curr != nil {
        this.stack = append(this.stack, curr)
        curr = curr.Left
    }

    return node.Val
}

func (this *BSTIterator) HasNext() bool {
    return len(this.stack) > 0
}