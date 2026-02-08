/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
type BSTIterator struct {
    stack []*TreeNode
}

func Constructor(root *TreeNode) BSTIterator {
    iter := BSTIterator{}
    iter.pushAll(root)
    return iter
}

func (this *BSTIterator) pushAll(node *TreeNode) {
    for node != nil {
        this.stack = append(this.stack, node)
        node = node.Left
    }
}

func (this *BSTIterator) Next() int {
    node := this.stack[len(this.stack)-1]
    this.stack = this.stack[:len(this.stack)-1]
    this.pushAll(node.Right)
    return node.Val
}

func (this *BSTIterator) HasNext() bool {
    return len(this.stack) > 0
}

/**
 * Your BSTIterator object will be instantiated and called as such:
 * obj := Constructor(root);
 * param_1 := obj.Next();
 * param_2 := obj.HasNext();
 */