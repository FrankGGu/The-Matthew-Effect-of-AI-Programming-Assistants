type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

type BSTIterator struct {
    stack []*TreeNode
}

func Constructor(root *TreeNode) BSTIterator {
    it := BSTIterator{}
    it.pushAll(root)
    return it
}

func (this *BSTIterator) pushAll(node *TreeNode) {
    for node != nil {
        this.stack = append(this.stack, node)
        node = node.Left
    }
}

func (this *BSTIterator) Next() int {
    topNode := this.stack[len(this.stack)-1]
    this.stack = this.stack[:len(this.stack)-1]
    this.pushAll(topNode.Right)
    return topNode.Val
}

func (this *BSTIterator) HasNext() bool {
    return len(this.stack) > 0
}