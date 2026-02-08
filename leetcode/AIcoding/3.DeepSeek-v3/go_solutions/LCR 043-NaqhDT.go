/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
type CBTInserter struct {
    root *TreeNode
    queue []*TreeNode
}

func Constructor(root *TreeNode) CBTInserter {
    queue := []*TreeNode{}
    q := []*TreeNode{root}
    for len(q) > 0 {
        node := q[0]
        q = q[1:]
        if node.Left != nil {
            q = append(q, node.Left)
        }
        if node.Right != nil {
            q = append(q, node.Right)
        }
        if node.Left == nil || node.Right == nil {
            queue = append(queue, node)
        }
    }
    return CBTInserter{root, queue}
}

func (this *CBTInserter) Insert(val int) int {
    newNode := &TreeNode{Val: val}
    node := this.queue[0]
    if node.Left == nil {
        node.Left = newNode
    } else {
        node.Right = newNode
        this.queue = this.queue[1:]
    }
    this.queue = append(this.queue, newNode)
    return node.Val
}

func (this *CBTInserter) Get_root() *TreeNode {
    return this.root
}

/**
 * Your CBTInserter object will be instantiated and called as such:
 * obj := Constructor(root);
 * param_1 := obj.Insert(val);
 * param_2 := obj.Get_root();
 */