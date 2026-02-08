type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

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
		if node.Left == nil || node.Right == nil {
			queue = append(queue, node)
		}
		if node.Left != nil {
			q = append(q, node.Left)
		}
		if node.Right != nil {
			q = append(q, node.Right)
		}
	}
	return CBTInserter{root: root, queue: queue}
}

func (this *CBTInserter) Insert(val int) int {
	node := &TreeNode{Val: val}
	parent := this.queue[0]
	if parent.Left == nil {
		parent.Left = node
	} else {
		parent.Right = node
		this.queue = this.queue[1:]
	}
	this.queue = append(this.queue, node)
	return parent.Val
}

func (this *CBTInserter) Get_root() *TreeNode {
	return this.root
}