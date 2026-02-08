type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

type CBTInserter struct {
	root  *TreeNode
	queue []*TreeNode
}

func Constructor(root *TreeNode) CBTInserter {
	queue := []*TreeNode{}
	queue = append(queue, root)
	i := 0
	for i < len(queue) {
		node := queue[i]
		if node.Left != nil {
			queue = append(queue, node.Left)
		}
		if node.Right != nil {
			queue = append(queue, node.Right)
		}
		i++
	}
	return CBTInserter{root: root, queue: queue}
}

func (this *CBTInserter) Insert(val int) int {
	node := &TreeNode{Val: val}
	for i := 0; i < len(this.queue); i++ {
		if this.queue[i].Left == nil {
			this.queue[i].Left = node
			this.queue = append(this.queue, node)
			return this.queue[i].Val
		} else if this.queue[i].Right == nil {
			this.queue[i].Right = node
			this.queue = append(this.queue, node)
			return this.queue[i].Val
		}
	}
	return -1
}

func (this *CBTInserter) Get_root() *TreeNode {
	return this.root
}