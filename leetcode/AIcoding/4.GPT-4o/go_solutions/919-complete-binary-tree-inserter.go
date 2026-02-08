type CBTInserter struct {
    root *TreeNode
    nodes []*TreeNode
}

func Constructor(root *TreeNode) CBTInserter {
    cbt := CBTInserter{root: root, nodes: []*TreeNode{}}
    queue := []*TreeNode{root}
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        cbt.nodes = append(cbt.nodes, node)
        if node.Left != nil {
            queue = append(queue, node.Left)
        }
        if node.Right != nil {
            queue = append(queue, node.Right)
        }
    }
    return cbt
}

func (this *CBTInserter) Insert(val int) int {
    newNode := &TreeNode{Val: val}
    parentIdx := (len(this.nodes) - 1) / 2
    if len(this.nodes)%2 == 0 {
        this.nodes[parentIdx].Left = newNode
    } else {
        this.nodes[parentIdx].Right = newNode
    }
    this.nodes = append(this.nodes, newNode)
    return this.nodes[parentIdx].Val
}

func (this *CBTInserter) Get_root() *TreeNode {
    return this.root
}