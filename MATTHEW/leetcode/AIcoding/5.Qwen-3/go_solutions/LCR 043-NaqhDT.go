package main

type CBTInserter struct {
    root *TreeNode
    queue []*TreeNode
}

func Constructor(root *TreeNode) CBTInserter {
    c := CBTInserter{root: root}
    c.queue = []*TreeNode{}
    if root != nil {
        c.queue = append(c.queue, root)
        for len(c.queue) > 0 {
            node := c.queue[0]
            c.queue = c.queue[1:]
            if node.Left != nil {
                c.queue = append(c.queue, node.Left)
            }
            if node.Right != nil {
                c.queue = append(c.queue, node.Right)
            }
        }
    }
    return c
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