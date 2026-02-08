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
    q := []*TreeNode{}
    queue := []*TreeNode{root}
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        if node.Left != nil {
            queue = append(queue, node.Left)
        }
        if node.Right != nil {
            queue = append(queue, node.Right)
        }
        if node.Left == nil || node.Right == nil {
            q = append(q, node)
        }
    }
    return CBTInserter{root: root, queue: q}
}

func (this *CBTInserter) Insert(val int) int {
    node := this.queue[0]
    newNode := &TreeNode{Val: val}
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