package main


type BSTIterator struct {
    stack []*TreeNode
}

func Constructor(root *TreeNode) BSTIterator {
    iter := BSTIterator{}
    for root != nil {
        iter.stack = append(iter.stack, root)
        root = root.Left
    }
    return iter
}

func (this *BSTIterator) Next() int {
    node := this.stack[len(this.stack)-1]
    this.stack = this.stack[:len(this.stack)-1]
    val := node.Val
    if node.Right != nil {
        node = node.Right
        for node != nil {
            this.stack = append(this.stack, node)
            node = node.Left
        }
    }
    return val
}

func (this *BSTIterator) HasNext() bool {
    return len(this.stack) > 0
}