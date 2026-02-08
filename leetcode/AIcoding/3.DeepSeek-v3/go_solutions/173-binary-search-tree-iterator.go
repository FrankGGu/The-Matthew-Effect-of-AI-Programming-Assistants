type BSTIterator struct {
    stack []*TreeNode
}

func Constructor(root *TreeNode) BSTIterator {
    iter := BSTIterator{}
    iter.leftmostInorder(root)
    return iter
}

func (this *BSTIterator) leftmostInorder(root *TreeNode) {
    for root != nil {
        this.stack = append(this.stack, root)
        root = root.Left
    }
}

func (this *BSTIterator) Next() int {
    top := this.stack[len(this.stack)-1]
    this.stack = this.stack[:len(this.stack)-1]
    if top.Right != nil {
        this.leftmostInorder(top.Right)
    }
    return top.Val
}

func (this *BSTIterator) HasNext() bool {
    return len(this.stack) > 0
}