type CBTInserter struct {
    root *TreeNode
    queue []*TreeNode
}

func Constructor(root *TreeNode) CBTInserter {
    cbt := CBTInserter{root: root}
    cbt.queue = append(cbt.queue, root)
    for len(cbt.queue) > 0 {
        node := cbt.queue[0]
        cbt.queue = cbt.queue[1:]
        if node.Left != nil {
            cbt.queue = append(cbt.queue, node.Left)
        }
        if node.Right != nil {
            cbt.queue = append(cbt.queue, node.Right)
        }
        if node.Left == nil || node.Right == nil {
            cbt.queue = append(cbt.queue, node)
        }
    }
    return cbt
}

func (this *CBTInserter) Insert(val int) int {
    newNode := &TreeNode{Val: val}
    parent := this.queue[0]
    if parent.Left == nil {
        parent.Left = newNode
    } else {
        parent.Right = newNode
        this.queue = this.queue[1:]
    }
    this.queue = append(this.queue, newNode)
    return parent.Val
}

func (this *CBTInserter) Get_root() *TreeNode {
    return this.root
}