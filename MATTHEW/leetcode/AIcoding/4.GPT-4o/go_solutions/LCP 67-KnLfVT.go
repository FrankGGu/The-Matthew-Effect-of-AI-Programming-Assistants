type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func decorateTree(root *TreeNode) *TreeNode {
    if root == nil {
        return nil
    }

    if root.Left == nil && root.Right == nil {
        return root
    }

    if root.Left != nil {
        root.Left = decorateTree(root.Left)
    }

    if root.Right != nil {
        root.Right = decorateTree(root.Right)
    }

    newNode := &TreeNode{Val: root.Val}
    if root.Left != nil {
        newNode.Left = root.Left
    }
    if root.Right != nil {
        newNode.Right = root.Right
    }

    return newNode
}