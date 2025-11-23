type CBTInserter struct {
    root *TreeNode
    queue []*TreeNode // Stores nodes that are not yet full, in level order
}

func Constructor(root *TreeNode)