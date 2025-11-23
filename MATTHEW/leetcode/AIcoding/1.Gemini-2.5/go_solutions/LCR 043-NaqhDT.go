type CBTInserter struct {
    root *TreeNode
    q    []*TreeNode // Queue of nodes that are not yet full (can accept children)
}

func Constructor(root *TreeNode) CBTInserter {
    cbt := CBTInserter{
        root: root,
        q:    make([]*TreeNode, 0),
    }

    if root == nil {
        return cbt
    }

    bfs_q := []*TreeNode{root}
    for len(bfs_q) > 0 {
        node := bfs_q[0]
        bfs_q = bfs_q[1:]

        if node.Left == nil || node.Right == nil {
            cbt.q = append(cbt.q, node)
        }

        if node.Left != nil {
            bfs_q = append(bfs_q, node.Left)
        }
        if node.Right != nil {
            bfs_q = append(bfs_q, node.Right)
        }
    }

    return cbt
}

func (this *CBTInserter) Insert(val int) int {
    newNode := &TreeNode{Val: val}

    parent := this.q[0]
    parentVal := parent.Val

    if parent.Left == nil {
        parent.Left = newNode
    } else {
        parent.Right = newNode
        this.q = this.q[1:]
    }

    this.q = append(this.q, newNode)

    return parentVal
}

func (this *CBTInserter) Get_root() *TreeNode {
    return this.root
}