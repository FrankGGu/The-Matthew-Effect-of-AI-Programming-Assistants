type BSTIterator struct {
    stack []*TreeNode
}

func Constructor(root *TreeNode) BSTIterator {
    iterator := BSTIterator{
        stack: make([]*TreeNode, 0),
    }
    for root != nil {
        iterator.stack = append(iterator.stack, root)
        root = root.Left
    }
    return iterator
}

func (this *BSTIterator) Next() int {
    node := this.stack[len(this.stack)-1]
    this.stack = this.stack[:len(this.stack)-1]

    if node.Right != nil {
        curr := node.Right
        for curr != nil {
            this.stack = append(this.stack, curr)
            curr = curr.Left
        }
    }
    return node.Val
}

func (this *BSTIterator) HasNext() bool {
    return len(this.stack) > 0
}