package main


type CBTInserter struct {
    root *TreeNode
    nodes []*TreeNode
}

func Constructor(root *TreeNode) CBTInserter {
    var nodes []*TreeNode
    queue := []*TreeNode{root}
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        nodes = append(nodes, node)
        if node.Left != nil {
            queue = append(queue, node.Left)
        }
        if node.Right != nil {
            queue = append(queue, node.Right)
        }
    }
    return CBTInserter{root, nodes}
}

func (this *CBTInserter) Insert(val int) int {
    node := &TreeNode{Val: val}
    this.nodes = append(this.nodes, node)
    parent := this.nodes[(len(this.nodes)-1)/2]
    if parent.Left == nil {
        parent.Left = node
    } else {
        parent.Right = node
    }
    return parent.Val
}

func (this *CBTInserter) Get_root() *TreeNode {
    return this.root
}